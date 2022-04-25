import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    title: qsTr("Info")

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
            text: rust.app_project + " " + rust.app_version + "\nbackend " + rust.app_backend + "\n\n" + rust.dev_project + "xxx " + rust.dev_version + "\nesp-idf " + rust.dev_esp_idf
        }
    }
}
