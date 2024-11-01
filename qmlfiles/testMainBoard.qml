
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtGraphicalEffects 1.0
import CanUtil 1.0

ApplicationWindow {
    visible: true
    width: 1024
    height: 600
    title: "QtQuick Gauge Example"
    color: "black";

//    Image {
//        id: bgimg
//        source: "./bg.png"
//        anchors.fill: parent
//        width: 1024;
//        height: 600;
//    }
    Head{
        id:headerPanel
        x:0;
        y:0;
    }


    Text {
        id: driveModeTxt
        x:battery.x+battery.width+20
        y:72+15+10
        color:"white"; //"#00cc00"
        font.pixelSize: 34
        font.weight: Font.Bold
        text: qsTr("MODE")
    }



    TurnLight{
        id:leftTurnLight
        x:364;
        y:18+72;
        source_path: "./leftArrow.png"
        on:true
    }

    Item{
        id:gearRect
        x:(1024-64)/2+15;
        y:18+72
        width: 64
        height:64
        Text {
            id: gearTxt
            color: "white"
            font.pixelSize: 64
            font.weight: Font.Bold
            text: qsTr("D")
        }
    }

    Text {
        id: readyTxt
        x:(parent.width-width)/2;
        y:18+72+64
        color:"white"; //"#00cc00"
        font.pixelSize: 64
        font.weight: Font.Bold
        text: qsTr("READY")
    }


    TurnLight{
        id:rightTurnLight
        x:1024-364-64;
        y:18+72;
        source_path: "./rightArrow.png"
    }

    SpeedPanel{
        id:speedPanel
        x:parent.width - width;
        y:(parent.height+72 -height)/2;
    }


    RpmPanel{
        id:rpmPanel
        x:0;
        y: (parent.height+72 -height)/2;
    }

    CurvedRectangle{
        width: 300
        height: 100
        color: "black"
        cornersRadius: [50,50,0,0]
        borderWidth: 1
        borderColor: "grey"
        x:(parent.width-width)/2;
        y:parent.height-100;
        Text {
            id: totalMiles
            x:(parent.width-width)/2;
            y:parent.height-80;
            text: qsTr("3000km")
            font.bold: false
            font.pixelSize: 35;
            color: "white"
        }
    }




    CanUtil{
        id:caninfoutil
        onSignalTest: {
            console.log("the num from signal is :",num);
            speedPanel.currentSpeed = num;
        }
    }

}

