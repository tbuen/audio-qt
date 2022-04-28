use backend::{Backend, Response};
use qmetaobject::listmodel::SimpleListModel;
use qmetaobject::prelude::*;
use qmetaobject::SimpleListItem;
use std::cell::RefCell;
//use std::collections::HashMap;

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

    track_list: qt_property!(RefCell<SimpleListModel<Track>>; CONST),

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

                        let mut list = self.track_list.borrow_mut();
                        list.insert(
                            0,
                            Track {
                                filename: String::from("TRACK01.OGG"),
                            },
                        );
                    }
                }
            }
        }
    }
}

#[derive(Default, SimpleListItem)]
struct Track {
    pub filename: String,
}

/*#[derive(Default, Clone)]
struct Track {
    filename: String,
}

#[derive(Default, QObject)]
struct Tracks {
    base: qt_base_class!(trait QAbstractListModel),
    count: qt_property!(i32; READ row_count NOTIFY count_changed),
    count_changed: qt_signal!(),
    list: Vec<Track>,

    add: qt_method!(fn(&mut self, filename: String)),
}

impl Tracks {
    fn add(&mut self, filename: String) {
        let end = self.list.len();
        println!("Add {} at {}", filename, end);
        (self as &mut dyn QAbstractListModel).begin_insert_rows(end as i32, end as i32);
        self.list.insert(end, Track { filename });
        (self as &mut dyn QAbstractListModel).end_insert_rows();
        self.count_changed();
    }
}

impl QAbstractListModel for Tracks {
    fn row_count(&self) -> i32 {
        self.list.len() as i32
    }
    fn data(&self, index: QModelIndex, role: i32) -> QVariant {
        let idx = index.row() as usize;
        println!("Index: {}", idx);
        if idx < self.list.len() {
            if role == USER_ROLE {
                QString::from(self.list[idx].filename.clone()).into()
            } else {
                QVariant::default()
            }
        } else {
            QVariant::default()
        }
    }
    fn role_names(&self) -> HashMap<i32, QByteArray> {
        let mut map = HashMap::new();
        map.insert(USER_ROLE, "filename".into());
        map
    }
}*/

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
