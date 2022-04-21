import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    title: qsTr("Home")

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: Component.status == Component.Ready ? pageIndicator.currentIndex : 1

        TrackList {}
        Track {}
        TrackInfo {}
    }

    PageIndicator {
        id: pageIndicator
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        currentIndex: swipeView.currentIndex
        count: swipeView.count
        interactive: true
    }
}
