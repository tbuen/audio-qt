import QtQuick 2.15
import QtQuick.Controls 2.15
import RustCode 1.0

Page {
    title: qsTr("Info")

    Info {
        id: info
    }

    Column {
        anchors.centerIn: parent
        spacing: 20

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            source: "/images/icon.svg"
            width: 128
            height: 128
        }

        Text {
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            font.bold: true
            text: info.app_name + " " + info.app_version + "\nbackend " + info.app_backend + "\n\n" + info.esp_project + "xxx " + info.esp_version + "\nesp-idf " + info.esp_idf
        }
    }
}
