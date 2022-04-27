import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import RustCode 1.0

Page {
    Tracks {
        id: trackModel

        Component.onCompleted: {
            add("TRACK01.OGG");
            add("TRACK02.OGG");
            add("TRACK03.OGG");
            add("TRACK04.OGG");
            add("TRACK05.OGG");
            add("TRACK06.OGG");
            add("TRACK07.OGG");
            add("TRACK08.OGG");
            add("TRACK09.OGG");
            add("TRACK10.OGG");
            add("TRACK11.OGG");
            add("TRACK12.OGG");
            add("TRACK13.OGG");
            add("TRACK14.OGG");
            add("TRACK15.OGG");
            add("TRACK16.OGG");
            add("TRACK17.OGG");
            add("TRACK18.OGG");
        }
    }

    ListView {
        //anchors.margins: 20
        //clip: true
        //spacing: 5

        anchors.fill: parent
        model: trackModel
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
