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

fn main() {
    my_resource();
    qml_register_type::<Api>(cstr!("RustCode"), 1, 0, cstr!("Api"));
    let mut engine = QmlEngine::new();
    engine.load_file("qrc:/qml/main.qml".into());
    engine.exec();
}
