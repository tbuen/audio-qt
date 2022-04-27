import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: root

    visible: true
    width: 360
    height: 640
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
        id: home

        anchors.fill: parent
    }

    header: ToolBar {
        RowLayout {
            anchors.fill: parent

            ToolButton {
                icon.name: "info-symbolic"
                onClicked: infoPopup.open()
            }

            Label {
                text: "ESP32 Audio"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }

            ToolButton {
                icon.name: "audio-volume-medium-symbolic"
                onClicked: {
                    home.toggleVolume();
                }
            }

        }

    }

}
