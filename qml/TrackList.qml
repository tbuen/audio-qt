import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    ListView {
        //anchors.margins: 20
        //clip: true
        //spacing: 5

        anchors.fill: parent
        model: rust.track_list
        delegate: trackDelegate
    }

    Component {
        //anchors.left: parent.left
        // anchors.verticalCenter: parent.verticalCenter
        //anchors.leftMargin: 4
        //radius: 8

        id: trackDelegate

        RowLayout {
            Text {
                text: filename
            }

        }

    }

}
