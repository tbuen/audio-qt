import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    function toggleVolume() {
        volume.visible = !volume.visible;
    }

    RowLayout {
        anchors.fill: parent

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            SwipeView {
                //currentIndex: 1

                id: swipeView

                anchors.fill: parent

                TrackList {
                }

                Track {
                }

                TrackInfo {
                }

            }

            PageIndicator {
                id: pageIndicator

                anchors.bottom: swipeView.bottom
                anchors.horizontalCenter: swipeView.horizontalCenter
                currentIndex: swipeView.currentIndex
                count: swipeView.count
            }

        }

        ColumnLayout {
            id: volume

            Layout.fillWidth: false
            Layout.fillHeight: true
            Layout.margins: 5
            visible: false

            Slider {
                id: slider

                Layout.alignment: Qt.AlignHCenter
                Layout.fillHeight: true
                orientation: Qt.Vertical
                snapMode: Slider.SnapAlways
                from: 0
                to: 127
                stepSize: 1
            }

            Text {
                horizontalAlignment: Text.AlignRight
                Layout.preferredWidth: tmetr.width
                text: slider.value - 127 + " dB"
            }

            TextMetrics {
                id: tmetr

                text: '-127 dB'
            }

        }

    }

}
