import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import RustCode 1.0

Page {
    title: qsTr("Info")

    Info {
        id: info
    }

    GridLayout {
        rowSpacing: 10
        columnSpacing: 10
        columns: 2
        anchors {
            left: parent.left
            top: parent.top
            margins: 20
        }

        Label {
            Layout.columnSpan: 2
            text: "App"
            font.bold: true
        }
        Label { text: "Name:" }
        Label { text: info.app_name }
        Label { text: "Version:" }
        Label { text: info.app_version }
        Label { text: "Backend:" }
        Label { text: info.app_backend }
        Label {
            Layout.columnSpan: 2
            text: "ESP32"
            font.bold: true
        }
        Label { text: "Project:" }
        Label { text: info.esp_project }
        Label { text: "Version:" }
        Label { text: info.esp_version }
        Label { text: "ESP-IDF:" }
        Label { text: info.esp_idf }
    }
}
