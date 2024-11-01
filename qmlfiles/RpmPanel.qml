import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtGraphicalEffects 1.0

Item {
    width: 364;
    height: 364;
   // color:"#999"
     property int currentRpm: 0
    Rectangle {
        id:powerRect
        width: 364
        height: 364
        radius: width / 2
        color: "#000"
        border.color: "#000"
        border.width: 4
        antialiasing: true;
        x:0;
        y:0;

        CircularGauge {
            id: powerPanel
            value: currentRpm
            anchors.centerIn: parent
            maximumValue: 100
            width: height
            height: parent.height

            // 动画效果
            Behavior on value {
                NumberAnimation { duration: 600; easing.type: Easing.InOutQuad }
            }

            style:  CircularGaugeStyle {
                tickmarkLabel: Text{
                    font.pixelSize: Math.max(6,0.16* outerRadius);
                    text: styleData.value
                    color: "white"
                    font.bold: true
                    antialiasing: true
                }

                minorTickmark: null

                background: Canvas {
                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.reset();
                       // paintBackground(ctx);
                    }

                    Text {
                        text: "x1000"
                        color: "white"
                        font.pixelSize: 0.16* outerRadius
                        y:65
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        id: powerText
                        font.pixelSize: 0.4* outerRadius
                        font.bold: true
                        text: kphInt
                        color: "white"
                        horizontalAlignment: Text.AlignRight
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.verticalCenter
                        anchors.topMargin: 0.1* outerRadius

                        readonly property int kphInt: control.value
                    }
                    Text {
                        text: "RPM"
                        color: "white"
                        font.pixelSize: 0.19* outerRadius
                        anchors.top: powerText.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                }
            }

        }

        // 模拟仪表盘变化
        Timer {
            interval: 1000; running: true; repeat: true
            onTriggered: {
                currentRpm = Math.random() * 180 - 90;  // 随机转动指针
            }
        }
    }
}
