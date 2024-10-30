import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    width: 264;
    height: 264;
    color:"#999"
     property int currentPower: 0
    // 圆形的表盘背景
    Rectangle {
        width: 250
        height: 250
        radius: width / 2
        anchors.centerIn: parent
        color: "#333"
        border.color: "#000"
        border.width: 4
        antialiasing: true;

        // 刻度线
        Canvas {
            id: canvas
            anchors.fill: parent
            onPaint: {
                var ctx = getContext("2d");
                ctx.fillStyle="lightblue";
                ctx.clearRect(0, 0, canvas.width, canvas.height);
               // ctx.fillRect(0, 0, canvas.width, canvas.height);
                var centerX = canvas.width / 2;
                var centerY = canvas.height / 2;
                var radius = Math.min(centerX, centerY) - 10;

                // 绘制外圈
                var startAngle = 0;
                var endAngle = 2*Math.PI;

                ctx.beginPath();
                ctx.arc(centerX,centerY,radius-5,startAngle,endAngle,false);
                ctx.lineWidth = 5;
                ctx.strokeStyle = "#999";
                ctx.stroke();

                // draw number
                // 绘制刻度
                var numTicks = 20;  // 刻度数量
                var fontRadius = radius - 30;  // 数字的位置稍微靠内一些
                for (var i = 0; i < numTicks-4; ) {
                    var angle = i * (360 / numTicks) * Math.PI / 180 + Math.PI *3/ 4;  // 起点为垂直向上
                    var tickLength = 15;

                    // 刻度线
                    var startX = centerX + (radius - tickLength) * Math.cos(angle);
                    var startY = centerY + (radius - tickLength) * Math.sin(angle);
                    var endX = centerX + radius * Math.cos(angle);
                    var endY = centerY + radius * Math.sin(angle);

                    ctx.beginPath();
                    ctx.moveTo(startX, startY);
                    ctx.lineTo(endX, endY);
                    ctx.lineWidth = 3;
                    ctx.strokeStyle = "#fff";
                    ctx.stroke();

                    // 刻度数字
                    var fontX = centerX + fontRadius * Math.cos(angle);
                    var fontY = centerY + fontRadius * Math.sin(angle);

                    ctx.font = "18px FreeSans";  // 设置字体大小和类型
                    ctx.fillStyle = "#fff";   // 字体颜色
                    ctx.textAlign = "center";
                    ctx.textBaseline = "middle";
                    ctx.fillText(i * 10, fontX, fontY);  // 每个刻度显示10的倍数（0，10，20...）
                    i+=3;
                }

                ctx.font = "38px FreeSans";  // 设置字体大小和类型
                ctx.fillStyle = "#fff";   // 字体颜色
                ctx.textAlign = "center";
                ctx.textBaseline = "middle";
                ctx.fillText(currentPower,parent.width/2,parent.height-135);

                ctx.font = "35px FreeSans";  // 设置字体大小和类型
                ctx.fillStyle = "#fff";   // 字体颜色
                ctx.textAlign = "center";
                ctx.textBaseline = "middle";
                ctx.fillText("KW",parent.width/2,parent.height-100);
            }
        }


        // 仪表盘指针
        Rectangle {
            id: pointer
            width: 4
            height: 100
            radius: 2
            color: "red"
            x:(parent.width-width)/2;
            y:parent.height/2-height;
            transformOrigin: Item.Bottom
            rotation: 0  // 指针的角度

            // 动画效果
            Behavior on rotation {
                NumberAnimation { duration: 500; easing.type: Easing.InOutQuad }
            }
        }

        // 模拟仪表盘变化
        Timer {
            interval: 1000; running: false; repeat: true
            onTriggered: {
                pointer.rotation = Math.random() * 180 - 90;  // 随机转动指针
            }
        }
    }
}
