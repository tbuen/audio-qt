import QtQuick 2.15
import QtQuick.Controls 2.15
import RustCode 1.0

Page {
    Api {
        id: api
    }

    Button {
        anchors.centerIn: parent
        text: qsTr("Press me!")
        onClicked: text = qsTr(api.get_greeting())
    }
}
