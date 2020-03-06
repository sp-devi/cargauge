import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0
import QtGraphicalEffects 1.0

CircularGauge {
    id: gauge

    style: CircularGaugeStyle {
        minimumValueAngle: 50
        maximumValueAngle: 320

        background: Rectangle {
            height: 620
            width: 620
            color: "transparent"
            anchors.centerIn: parent
            radius: 310

            Image {
                anchors.fill: parent
                source: "qrc:/assets/gauge.png"
                asynchronous: true
                sourceSize {
                    width: width
                }
            }

            function degreesToRadians(degrees) {
                return degrees * (Math.PI / 180);
            }

            Canvas {
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();

                    ctx.beginPath();
                    ctx.strokeStyle = "#e34c22";
                    ctx.lineWidth = outerRadius * 0.02;
                    ctx.stroke();
                }
            }
        }

        needle: Item {
            y: outerRadius * 0.95
            height: outerRadius * 0.9
            antialiasing: true
            Image {
                id: needle
                source: "qrc:/assets/needle.png"
                mirror: true
                height: parent.height
                width: height * 0.16
                asynchronous: true
                antialiasing: true
            }


            Glow {
                anchors.fill: needle
                radius: 5
                samples: 10
                // @6500RPM change to red
                // This is Definely not a good idea
                color: value <  162.5 ? "white": "red"
                source: needle
            }
        }

        foreground: Item {
            FontLoader {
                id: speedFont
                source: "qrc:/assets/DejaVuSansMono-Bold.ttf"
            }
            Column {
                anchors.centerIn: parent
                spacing: 10
                leftPadding: 20
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: gauge.value.toFixed(0)
                    font.family: speedFont.name
                    font.pixelSize: outerRadius * 0.3
                    color: "white"
                    antialiasing: true
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "km/h"
                    font.family: speedFont.name
                    font.pixelSize: outerRadius * 0.3
                    color: "white"
                    antialiasing: true
                }
            }
        }

        tickmark: null
        tickmarkLabel: null
        minorTickmark: null
    }
}
