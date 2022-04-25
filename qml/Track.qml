import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    Button {
        anchors.centerIn: parent
        text: qsTr("Press me!")
        onClicked: text = rust.get_greeting()
    }

}
