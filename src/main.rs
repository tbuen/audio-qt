use backend::{Backend, Response};
use qmetaobject::prelude::*;

qrc!(my_resource,
    "/" {
        "qml/main.qml",
        "qml/Home.qml",
        "qml/Info.qml",
        "qml/TrackList.qml",
        "qml/Track.qml",
        "qml/TrackInfo.qml",
        "images/icon.svg",
    },
);

#[derive(Default, QObject)]
struct Rust {
    base: qt_base_class!(trait QObject),

    backend: Option<Backend>,

    app_project: qt_property!(String; READ app_project CONST),
    app_version: qt_property!(String; READ app_version CONST),
    app_backend: qt_property!(String; READ app_backend CONST),
    dev_project: qt_property!(String; NOTIFY dev_project_changed),
    dev_version: qt_property!(String; NOTIFY dev_version_changed),
    dev_esp_idf: qt_property!(String; NOTIFY dev_esp_idf_changed),

    dev_project_changed: qt_signal!(),
    dev_version_changed: qt_signal!(),
    dev_esp_idf_changed: qt_signal!(),

    get_greeting: qt_method!(fn(&self) -> String),
    start_backend: qt_method!(fn(&mut self)),
    stop_backend: qt_method!(fn(&mut self)),
    idle: qt_method!(fn(&mut self)),
}

impl Rust {
    fn app_project(&self) -> String {
        String::from(env!("CARGO_PKG_NAME"))
    }

    fn app_version(&self) -> String {
        String::from(env!("VERSION"))
    }

    fn app_backend(&self) -> String {
        String::from(backend::VERSION)
    }

    fn get_greeting(&self) -> String {
        String::from("Hello World!")
    }

    fn start_backend(&mut self) {
        if self.backend.is_none() {
            println!("start backend");
            self.backend = Some(Backend::new());
        }
    }

    fn stop_backend(&mut self) {
        if let Some(mut b) = self.backend.take() {
            println!("stop backend");
            b.stop();
        }
    }

    fn idle(&mut self) {
        if let Some(b) = &self.backend {
            println!("idle");
            if let Some(resp) = b.receive() {
                match resp {
                    Response::Info(info) => {
                        println!("Received: {:?}", info);
                        self.dev_project = String::from(info.project);
                        self.dev_version = String::from(info.version);
                        self.dev_esp_idf = String::from(info.esp_idf);
                        self.dev_project_changed();
                        self.dev_version_changed();
                        self.dev_esp_idf_changed();
                    }
                }
            }
        }
    }
}

fn main() {
    my_resource();
    let qml_obj = QObjectBox::new(Rust {
        ..Default::default()
    });
    let mut engine = QmlEngine::new();
    engine.set_object_property(QString::from("rust"), qml_obj.pinned());
    engine.load_file(QString::from("qrc:/qml/main.qml"));
    engine.exec();
    println!("Exiting gracefully...");
}
