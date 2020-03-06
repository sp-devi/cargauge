import QtQuick 2.7
import QtQuick.Controls 2.0

ApplicationWindow {
    visible: true
    width: 1920
    height: 720
    title: qsTr("Electric Car Gauge")


    background: BorderImage {
        id: background
        source: "qrc:/assets/background.png"
        width: 1920; height: 720
    }


    CarGauge {
        maximumValue: 200
        minimumValue: 0
        property bool isSpeeding: false
        property bool isSlowing: false
        value: isSpeeding ? maximumValue: (isSlowing ? minimumValue : value)

        anchors {
            fill: parent
            margins: window.height * 0.2
        }

        anchors.centerIn: parent

        Keys.onUpPressed: isSpeeding = true
        Keys.onDownPressed: isSlowing = true
        Keys.onReleased: {
            if (event.key === Qt.Key_Up) {
                isSpeeding  = false;
                event.accepted = true
            }  else if (event.key === Qt.Key_Down) {
                isSlowing = false;
                event.accepted = true
            }
        }

        Component.onCompleted: forceActiveFocus()

        Behavior on value {
            NumberAnimation {
                duration: 8000
            }
        }

    }
}
