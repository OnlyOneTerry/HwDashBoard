import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.1
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4

Rectangle {
    width: 260
    height: 260
    radius: width / 2
    color: "black"
    border.color: "#000"
    border.width: 4
    antialiasing: true;
    property int cirlelineWidth: 4
    property int cirleSegmentCount: 4
    // 刻度线
    Canvas {
        id: canvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            var centerX = canvas.width / 2;
            var centerY = canvas.height / 2;
            var radius = Math.min(centerX, centerY) - 10;

            //绘制警告线

            //定义渐变弧线
            var gradient = ctx.createLinearGradient(100,100,300,300);
            gradient.addColorStop(0,"blue");
            gradient.addColorStop(0.1,"green");
            gradient.addColorStop(1,"red");

            var step = 32/cirleSegmentCount;
            var adjustVal = Math.PI/14;
            if(cirleSegmentCount == 4)
            {
                for(var i = 0;i<cirleSegmentCount;i++)
                {
                    var start_angle = Math.PI*2/32*(i*step)+adjustVal;
                    var end_angle = Math.PI*2/32*(i*step+6)+adjustVal;
                    ctx.beginPath();
                    ctx.arc(centerX,centerY,radius-5,start_angle,end_angle,false);
                    ctx.lineWidth = cirlelineWidth;
                    ctx.strokeStyle = "#66ff33";
                    ctx.stroke();

                    start_angle = Math.PI*2/32*(i*step+6)+adjustVal;
                    end_angle = Math.PI*2/32*(i*step+8)+adjustVal;
                    ctx.beginPath();
                    ctx.arc(centerX,centerY,radius-5,start_angle,end_angle,false);
                    ctx.lineWidth = cirlelineWidth;
                    ctx.strokeStyle = "black";
                    ctx.stroke();

                }
            }
            else if(cirleSegmentCount == 8)
            {
                for(var j = 0;j<cirleSegmentCount;j++)
                {
                    start_angle = Math.PI*2/32*(j*step)+adjustVal;
                    end_angle = Math.PI*2/32*(j*step+2)+adjustVal;
                    ctx.beginPath();
                    ctx.arc(centerX,centerY,radius-5,start_angle,end_angle,false);
                    ctx.lineWidth = cirlelineWidth;
                    ctx.strokeStyle = "#66ff33";
                    ctx.stroke();

                    start_angle = Math.PI*2/32*(j*step+2)+adjustVal;
                    end_angle = Math.PI*2/32*(j*step+4)+adjustVal;
                    ctx.beginPath();
                    ctx.arc(centerX,centerY,radius-5,start_angle,end_angle,false);
                    ctx.lineWidth = cirlelineWidth;
                    ctx.strokeStyle = "black";
                    ctx.stroke();

                }
            }
        }
    }
}
