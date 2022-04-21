import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: "ESP32 Audio"

    header: ToolBar {
        ToolButton {
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }
    }

    Drawer {
        id: drawer
        interactive: false

        Column {
            anchors.fill: parent

            ItemDelegate {
                id: infoItem
                text: qsTr("Info")
                icon.name: "info-symbolic"
                onClicked: {
                    stackView.push(infoPage)
                    drawer.close()
                }
            }
        }
    }

    Component {
        id: infoPage
        Info {}
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: Home {}
    }
}
