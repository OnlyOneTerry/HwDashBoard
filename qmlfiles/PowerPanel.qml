import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtGraphicalEffects 1.0

Item {
    width: 364;
    height: 364;
   // color:"#999"
     property int currentPower: 0
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
            value: 10;//valueSource.kph
            anchors.centerIn: parent
            maximumValue: 100
            width: height
            height: parent.height


            style:  CircularGaugeStyle {
                tickmarkLabel: Text{
                    font.pixelSize: Math.max(6,0.16* outerRadius);
                    text: styleData.value
                    color: "yellow"
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
    }
}
