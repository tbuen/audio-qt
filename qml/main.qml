import QtQuick 2.15
import QtQuick.Controls 2.15
import RustCode 1.0

ApplicationWindow {
    id: root

    width: 200
    height: 100
    title: "My Qt App"
    visible: true

    Api {
        id: api
    }

    Button {
        anchors.centerIn: parent
        text: "Press me!"
        onClicked: text = api.get_greeting()
    }
}
