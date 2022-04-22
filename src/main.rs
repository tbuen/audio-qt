use cstr::cstr;
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
struct Api {
    base: qt_base_class!(trait QObject),
    get_greeting: qt_method!(fn(&mut self) -> QString),
}

impl Api {
    fn get_greeting(&mut self) -> QString {
        "Hello World!".into()
    }
}

#[derive(Default, QObject)]
struct Info {
    base: qt_base_class!(trait QObject),
    app_name: qt_property!(String; READ app_name CONST),
    app_version: qt_property!(String; READ app_version CONST),
    app_backend: qt_property!(String; READ app_backend CONST),
    esp_project: qt_property!(String; READ esp_project CONST),
    esp_version: qt_property!(String; READ esp_version CONST),
    esp_idf: qt_property!(String; READ esp_idf CONST),
}

impl Info {
    fn app_name(&self) -> String {
        env!("CARGO_PKG_NAME").into()
    }
    fn app_version(&self) -> String {
        env!("VERSION").into()
    }
    fn app_backend(&self) -> String {
        backend::VERSION.into()
    }
    fn esp_project(&self) -> String {
        String::new()
    }
    fn esp_version(&self) -> String {
        String::new()
    }
    fn esp_idf(&self) -> String {
        String::new()
    }
}

fn main() {
    my_resource();
    qml_register_type::<Api>(cstr!("RustCode"), 1, 0, cstr!("Api"));
    qml_register_type::<Info>(cstr!("RustCode"), 1, 0, cstr!("Info"));
    let mut engine = QmlEngine::new();
    engine.load_file("qrc:/qml/main.qml".into());
    engine.exec();
}
