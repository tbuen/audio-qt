import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    TabBar {
        id: bar

        width: parent.width

        TabButton {
            text: qsTr("Files")
        }

        TabButton {
            text: qsTr("Albums")
        }

    }

    StackLayout {
        width: parent.width
        anchors.top: bar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        currentIndex: bar.currentIndex

        FileList {
        }

        Item {
        }

    }

}
