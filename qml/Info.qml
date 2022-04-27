import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Popup {
    anchors.centerIn: Overlay.overlay
    modal: true

    enter: Transition {
        NumberAnimation {
            property: "opacity"
            from: 0
            to: 1
        }

    }

    exit: Transition {
        NumberAnimation {
            property: "opacity"
            from: 1
            to: 0
        }

    }

    background: Rectangle {
        radius: 20
    }

    contentItem: Item {
        ColumnLayout {
            spacing: 20

            Image {
                Layout.leftMargin: 20
                Layout.rightMargin: 20
                Layout.topMargin: 20
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 128
                Layout.preferredHeight: 128
                source: "/images/icon.svg"
            }

            Text {
                Layout.leftMargin: 20
                Layout.rightMargin: 20
                Layout.bottomMargin: 20
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Qt.application.font.pixelSize * 1.6
                text: {
                    if (rust.dev_project != "")
                        rust.app_project + " " + rust.app_version + "\nbackend " + rust.app_backend + "\n\n" + rust.dev_project + " " + rust.dev_version + "\nesp-idf " + rust.dev_esp_idf;
                    else
                        rust.app_project + " " + rust.app_version + "\nbackend " + rust.app_backend + "\n\nconnection\nfailed";
                }
            }

        }

    }

}
