import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    ToolBar {
        id: toolbar

        ToolButton {
            icon.name: 'go-up-symbolic'
        }

    }

    ListView {
        //spacing: 5
        //highlight: Rectangle {
        //    color: 'lightsteelblue'
        //    radius: 5
        //}

        id: list

        clip: true
        anchors.top: toolbar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        model: rust.track_list
        delegate: delegate
        focus: true
    }

    Component {
        id: delegate

        ColumnLayout {
            //spacing: list.spacing
            width: list.width

            Text {
                Layout.margins: 10
                font.pixelSize: Qt.application.font.pixelSize * 1.6
                text: "TRACK01.OGG"
            }

            Rectangle {
                color: "#999999"
                Layout.preferredHeight: 1
                Layout.fillWidth: true
                visible: (index !== (list.count - 1))
            }

        }

    }

}
