import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: root

    visible: true
    width: 640
    height: 480
    title: "ESP32 Audio"
    Component.onCompleted: rust.start_backend()
    onClosing: rust.stop_backend()

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: rust.idle()
    }

    Info {
        id: infoPopup
    }

    Home {
    anchors.fill: parent
    }

    header: ToolBar {
        ToolButton {
            icon.name: "info-symbolic"
            onClicked: infoPopup.open()
        }

        Label {
            text: "ESP32 Audio"
            anchors.centerIn: parent
        }

    }

}
