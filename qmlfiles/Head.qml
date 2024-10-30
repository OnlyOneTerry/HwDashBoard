import QtQuick 2.0

Rectangle {
    id:header
    width: 1024;
    height: 72;
    color: "#000000"
    property  string date:new Date().toLocaleTimeString();
    Rectangle{
        id:date_rect
        x:110
        y:0
        width: 191
        height: parent.height
        color: "#000000"
        Text {
            id: dateTxt
            color:"white"
            font.pixelSize: 32
            font.weight: Font.Bold
            anchors.centerIn: parent;
            text: date;
        }
    }

    Rectangle{
        id:atmosphere_rect
        x:parent.width-200
        color: "#000000"
        y:0
        width: 92;
        height:parent.height;
        Image {
            id: atmosphere
            width: 36;
            height: 36;
            //source: "file"
        }

        Text {
            id: temperature
            text: qsTr("37℃")
            font.weight: Font.Bold
            color:"white"
            font.pixelSize: 32
            anchors.centerIn: parent;
        }
    }


    Image {
        id: bluetooth
        x:916;
        y:18;
        width: 36;
        height: 36;
        source: "./bluetooth.png";
    }

    Image {
        id: wifi
        x:952;
        y:18;
        source: "./wifi.png"
        width: 36;
        height: 36;
    }

    Timer{
        id:updateDateTimer
        interval: 1000
        running: true
        repeat: true
        onTriggered: date = Date().toString();
    }
}
