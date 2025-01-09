import QtQuick 2.0

Rectangle {
    id:header
    width: 1024;
    height: 72;
    color: "#000000"
    property  string time:"00:00";
    property int remainMile: 0
    property alias  battery: battery


    property int frameCount: 0
    property real lastTime: 0.0
    property real frameRate: 0.0

    Rectangle{
        id:time_rect
        x:10
        y:0
        width: 100
        height: parent.height
        color: "#000000"
        Text {
            id: timeTxt
            color:"white"
            font.pixelSize: 32
            font.weight: Font.Bold
            anchors.centerIn: parent;
            text: time;
        }


        Timer {
            id: timer
            interval: 16 // 设置每帧的时间间隔，假设60FPS的帧间隔为16ms
            running: true
            repeat: true
            onTriggered: {
                // 增加帧数
                frameCount++

                // 计算时间差
                var currentTime = Date.now() / 1000.0
                var deltaTime = currentTime - lastTime

                // 计算帧率
                if (deltaTime >= 1.0) {
                    frameRate = frameCount / deltaTime
                    frameCount = 0
                    lastTime = currentTime
                }
            }
        }

        Text {
            text: "FPS: " + frameRate.toFixed(2)
            font.pointSize: 12
            x:100
            y:0
            color: "white"
        }

    }

    Image {
        id: bluetooth
        x:1024-36*2-120-70;
        y:18;
        width: 36;
        height: 36;
        source: "qrc:/img/bluetooth.png";
    }

    Image {
        id: wifi
        x:1024-36-110-70;
        y:18;
        source: "qrc:/img/wifi.png"
        width: 36;
        height: 36;
    }

    Battery{
        id:battery
        x:1024-90-70
        y:18
    }

    Text {
        id: remainMileage
        text: remainMile+ qsTr("km")
        color: "white"
        font.pixelSize: 30
        font.bold: true
        x:1024-90
        y:20
    }

    Timer{
        id:updateDateTimer
        interval: 1000
        running: false
        repeat: true
        onTriggered:
        {
            var currentTime = new Date();
            var hours = currentTime.getHours().toString().padStart(2, '0'); // 补零
            var minutes = currentTime.getMinutes().toString().padStart(2, '0'); // 补零
            time = hours + ":" + minutes; // 格式化为 HH:MM
        }
    }


}
