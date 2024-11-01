import QtQuick 2.0

Rectangle {
    id:header
    width: 1024;
    height: 72;
    color: "#000000"
    property  string time:"00:00";
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
    }

    Image {
        id: bluetooth
        x:1024-36*2-120;
        y:18;
        width: 36;
        height: 36;
        source: "qrc:/img/bluetooth.png";
    }

    Image {
        id: wifi
        x:1024-36-100;
        y:18;
        source: "qrc:/img/wifi.png"
        width: 36;
        height: 36;
    }

    Battery{
        id:battery
        x:1024-80
        y:18
    }

    Timer{
        id:updateDateTimer
        interval: 1000
        running: true
        repeat: true
        onTriggered: /*date = Date().toLocaleString(Qt.locale(),"HH:mm");*/
        {
            var currentTime = new Date();
            var hours = currentTime.getHours().toString().padStart(2, '0'); // 补零
            var minutes = currentTime.getMinutes().toString().padStart(2, '0'); // 补零
            time = hours + ":" + minutes; // 格式化为 HH:MM
        }
    }

}
