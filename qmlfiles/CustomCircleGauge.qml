import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.3
import QtQuick.Extras.Private 1.0
import QtGraphicalEffects 1.0

CircularGauge {
    id: gauge
    // Define the radius and angle for the arc
    property real arcAngle: 180  // Angle in degrees
    property real arcRadius: 90
    property int chargeStatusIndex :0
    function speedColor(value){
        if(value < 60 ){
            return "green"
        } else if(value > 60 && value < 150){
            return "yellow"
        }else{
            return "Red"
        }
    }

    style: CircularGaugeStyle {
        labelStepSize: 10
        labelInset: outerRadius*0.10
        tickmarkInset: outerRadius*0.16
        minorTickmarkInset: outerRadius*0.18
        minimumValueAngle:-90 //-155
        maximumValueAngle:90 //155

        background:Rectangle {
            implicitHeight: gauge.height
            implicitWidth: gauge.width
            color: "#000000"
            anchors.centerIn: parent

            Canvas {
                id:circularCanva
                property int value: gauge.value

                anchors.fill: parent

                Component.onCompleted: requestPaint()

                function degreesToRadians(degrees) {
                    return degrees * (Math.PI / 180);
                }

                function createLinearGradient(ctx, start, end, colors) {
                    var gradient = ctx.createLinearGradient(start.x, start.y, end.x, end.y);
                    for (var i = 0; i < colors.length; i++) {
                        gradient.addColorStop(i / (colors.length - 1), colors[i]);
                    }
                    return gradient;
                }

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();

                    // Define the gradient colors for the filled arc
                    var gradientColors = [
                                "#AAFFFF",// Start color
                                "#AAFFFF",    // End color
                            ];

                    // Calculate the start and end angles for the filled arc
                    var startAngle = valueToAngle(gauge.minimumValue) - 90;
                    var endAngle = valueToAngle(250) - 90;

                    // Create a linear gradient
                    var gradient = createLinearGradient(ctx, { x: 0, y: 0 }, { x: outerRadius * 2, y: 0 }, gradientColors);
                    ctx.globalAlpha = 0.5;
                    // Loop through the gradient colors and fill the arc segment with each color
                    for (var i = 0; i < gradientColors.length; i++) {
                        var gradientColor = gradientColors[i];
                        var angle = startAngle + (endAngle - startAngle) * (i / (gradientColors.length - 1));

                        ctx.beginPath();
                        ctx.lineWidth = 1.5;
                        ctx.strokeStyle = gradient;
                        ctx.arc(outerRadius,
                                outerRadius,
                                outerRadius - 57,
                                degreesToRadians(angle),
                                degreesToRadians(endAngle));
                        ctx.stroke();
                    }
                }
            }

            Canvas {
                property int value: gauge.value

                anchors.fill: parent
                Component.onCompleted: requestPaint()

                function degreesToRadians(degrees) {
                    return degrees * (Math.PI / 180);
                }

                function createLinearGradient(ctx, start, end, colors) {
                    var gradient = ctx.createLinearGradient(start.x, start.y, end.x, end.y);
                    for (var i = 0; i < colors.length; i++) {
                        gradient.addColorStop(i / (colors.length - 1), colors[i]);
                    }
                    return gradient;
                }

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();

                    // Define the gradient colors for the filled arc
                    var gradientColors = [
                                "#163546",// Start color
                                "#163546",    // End color
                            ];

                    // Calculate the start and end angles for the filled arc
                    var startAngle = valueToAngle(gauge.minimumValue) - 90;
                    var endAngle = valueToAngle(250) - 90;

                    // Create a linear gradient
                    var gradient = createLinearGradient(ctx, { x: 0, y: 0 }, { x: outerRadius * 2, y: 0 }, gradientColors);

                    // Loop through the gradient colors and fill the arc segment with each color
                    for (var i = 0; i < gradientColors.length; i++) {
                        var gradientColor = gradientColors[i];
                        var angle = startAngle + (endAngle - startAngle) * (i / (gradientColors.length - 1));

                        ctx.beginPath();
                        ctx.lineWidth = outerRadius * 0.08;
                        ctx.strokeStyle = gradient;
                        ctx.arc(outerRadius,
                                outerRadius,
                                outerRadius - 75-10,
                                degreesToRadians(-180),//angle
                                degreesToRadians(0));//endAngle
                        ctx.stroke();
                    }
                }
            }


            Canvas {
                id:canvas
                property int value: gauge.value
                property int  statusIndex:gauge.chargeStatusIndex
                anchors.fill: parent
                onValueChanged: requestPaint()

                function degreesToRadians(degrees) {
                    return degrees * (Math.PI / 180);
                }

                function createLinearGradient(ctx, start, end, colors) {
                    var gradient = ctx.createLinearGradient(start.x, start.y, end.x, end.y);
                    for (var i = 0; i < colors.length; i++) {
                        gradient.addColorStop(i / (colors.length - 1), colors[i]);
                    }
                    return gradient;
                }

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();

                    // Define the gradient colors for the filled arc
                    var gradientColors = [
                                "#6369FF",// Start color
                                "#63FFFF",    // End color
                                "#FFFF00",
                                "#FF0000"
                            ];

                    // Calculate the start and end angles for the filled arc
                    var startAngle = valueToAngle(gauge.minimumValue) - 90;
                    var endAngle = valueToAngle(gauge.value) - 90;

                    // Create a linear gradient
                    var gradient = createLinearGradient(ctx, { x: 0, y: 0 }, { x: outerRadius * 2, y: 0 }, gradientColors);

                    // Loop through the gradient colors and fill the arc segment with each color
                    for (var i = 0; i < gradientColors.length; i++) {
                        var gradientColor = gradientColors[i];
                        var angle = startAngle + (endAngle - startAngle) * (i / (gradientColors.length - 1));

                        ctx.beginPath();
                        ctx.lineWidth = outerRadius * 0.13;
                        ctx.strokeStyle = gradient;
                        ctx.arc(outerRadius,
                                outerRadius,
                                outerRadius - 75-10,
                                degreesToRadians(angle),
                                degreesToRadians(endAngle));
                        ctx.stroke();
                    }

                    //out ring
                    var centerX = canvas.width / 2;
                    var centerY = canvas.height / 2;
                    var radius = Math.min(centerX, centerY)-3;
                    var start_angle = 0;
                    var end_angle = Math.PI*2;
                    ctx.beginPath();
                    ctx.arc(centerX,centerY,radius,start_angle,end_angle,false);
                    ctx.lineWidth = 2;
                    ctx.strokeStyle = "#31DBEE";
                    ctx.stroke();

                    //BATTERY?
                    var adjustVal = 0;
                    var k = 0;
                    for(var j = 0;j<6;j++)
                    {
                        start_angle = Math.PI*2/24*k+adjustVal;
                        k=k+0.2;
                        end_angle = Math.PI*2/24*k+adjustVal;
                        ctx.beginPath();
                        ctx.arc(centerX,centerY,outerRadius-75-10,start_angle,end_angle,false);
                        ctx.lineWidth = outerRadius * 0.13;
                        ctx.strokeStyle = "black";
                        ctx.stroke();

                        start_angle = Math.PI*2/24*k+adjustVal;
                        k=k+0.6;
                        end_angle = Math.PI*2/24*k+adjustVal;
                        ctx.beginPath();
                        ctx.arc(centerX,centerY,outerRadius-75-10,start_angle,end_angle,false);
                        ctx.lineWidth = outerRadius * 0.13;
                        ctx.strokeStyle = "#ffffff";
                        ctx.stroke();
                    }

                    //                     k = 0;
                    //                    for(var m = 0;m<statusIndex;m++)
                    //                    {
                    //                        start_angle = Math.PI*2/24*k+adjustVal;
                    //                        k=k+0.2;
                    //                        end_angle = Math.PI*2/24*k+adjustVal;
                    //                        ctx.beginPath();
                    //                        ctx.arc(centerX,centerY,outerRadius-75-10,start_angle,end_angle,false);
                    //                        ctx.lineWidth = outerRadius * 0.13;
                    //                        ctx.strokeStyle = "black";
                    //                        ctx.stroke();

                    //                        start_angle = Math.PI*2/24*k+adjustVal;
                    //                        k=k+0.6;
                    //                        end_angle = Math.PI*2/24*k+adjustVal;
                    //                        ctx.beginPath();
                    //                        ctx.arc(centerX,centerY,outerRadius-75-10,start_angle,end_angle,false);
                    //                        ctx.lineWidth = outerRadius * 0.13;
                    //                        ctx.strokeStyle = "#0AFFE8";
                    //                        ctx.stroke();
                    //                    }

                    var h = 0.8*6+0.2;
                    for(var m = 0;m<statusIndex;m++)
                    {
                        h=h-0.6-0.2;
                        start_angle = Math.PI*2/24*h+adjustVal;
                        h=h+0.6;
                        end_angle = Math.PI*2/24*h+adjustVal;
                        ctx.beginPath();
                        ctx.arc(centerX,centerY,outerRadius-75-10,start_angle,end_angle,false);
                        ctx.lineWidth = outerRadius * 0.13;
                        ctx.strokeStyle = "#0AFFE8";
                        ctx.stroke();
                        h=h-0.2-0.6;
                        start_angle = Math.PI*2/24*h+adjustVal;
                        h=h+0.2;
                        end_angle = Math.PI*2/24*h+adjustVal;
                        ctx.beginPath();
                        ctx.arc(centerX,centerY,outerRadius-75-10,start_angle,end_angle,false);
                        ctx.lineWidth = outerRadius * 0.13;
                        ctx.strokeStyle = "black";
                        ctx.stroke();
                    }

                    //temperature
                    k = 7;
                    for(var j1 = 0;j1<6;j1++)
                    {
                        start_angle = Math.PI*2/24*k+adjustVal;
                        k=k+0.2;
                        end_angle = Math.PI*2/24*k+adjustVal;
                        ctx.beginPath();
                        ctx.arc(centerX,centerY,outerRadius-75-10,start_angle,end_angle,false);
                        ctx.lineWidth = outerRadius * 0.13;
                        ctx.strokeStyle = "black";
                        ctx.stroke();


                        start_angle = Math.PI*2/24*k+adjustVal;
                        k=k+0.6;
                        end_angle = Math.PI*2/24*k+adjustVal;
                        ctx.beginPath();
                        ctx.arc(centerX,centerY,outerRadius-75-10,start_angle,end_angle,false);
                        ctx.lineWidth = outerRadius * 0.13;
                        if(k<9)
                        {
                            ctx.strokeStyle = "#0AFFE8";
                        }
                        else
                        {
                            ctx.strokeStyle = "#ffffff";
                        }


                        ctx.stroke();
                    }
                }

            }

        }


        needle: Item {
            y: -outerRadius * 0.90
            height: outerRadius * 0.02
            Image {
                id: needle
                source: "qrc:/img/Rectangle 4.png"
                width: height * 0.06
                asynchronous: true
                antialiasing: true
            }

            Glow {
                anchors.fill: needle
                radius: 5
                samples: 10
                color: "white"
                source: needle
            }
        }

        foreground: Item {
            id:foregroundArea

            Label{
                text: "x1000/min"
                font.pixelSize: 20
                font.family: "Inter"
                color: "#FFFFFF"
                font.bold: Font.DemiBold
                x:(parent.width-width)/2;
                y:130
            }

            ColumnLayout{
                x:(parent.width-width)/2;
                y:200

                Label{
                    text: gauge.value.toFixed(0)
                    font.pixelSize: 85
                    font.family: "Inter"
                    color: "#FFFFFF"
                    font.bold: Font.DemiBold
                    Layout.alignment: Qt.AlignHCenter
                }
                Label{
                    text: "km/h"
                    font.pixelSize: 28
                    font.family: "Inter"
                    color: "#FFFFFF"
                    opacity: 1
                    font.bold: Font.Normal
                    Layout.alignment:Qt.AlignHCenter
                }
            }

            Image {
                id: temperImg
                width: 40
                height:40
                x:50
                y:350
                source: "qrc:/img/colder_overhot_dis.png"
            }

            Image {
                id: pluginImg
                width: 40
                height:40
                x:415
                y:350
                source: "qrc:/img/plugged_in.png"
            }

        }


        tickmarkLabel:  Text {
            visible: true
            font.pixelSize: Math.max(6, outerRadius * 0.10)
            text: styleData.value/10
            color: styleData.value <= gauge.value ? "white" : "#777776"
            antialiasing: true
            font.bold: true
        }

        tickmark:Rectangle {
            implicitWidth: outerRadius * 0.008
            implicitHeight: outerRadius * 0.10

            antialiasing: true
            smooth: true
            color: styleData.value <= gauge.value ? "white" : "darkGray"
        }
        minorTickmark: Rectangle {
            implicitWidth: outerRadius * 0.008
            implicitHeight: outerRadius * 0.05

            antialiasing: true
            smooth: true
            color: styleData.value <= gauge.value ? "white" : "darkGray"
        }
    }
}
