
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtGraphicalEffects 1.0
import CanUtil 1.0

ApplicationWindow {
    visible: true
    width: 1024
    height: 600
    title: "QtQuick Gauge Example"
    color: "#999";

    Image {
        id: bgimg
        source: "./bg.png"
        anchors.fill: parent
        width: 1024;
        height: 600;
    }
    Head{
        id:headerPanel
        x:0;
        y:0;
    }


    Item{
        id:leftTurnRect
        x:364;
        y:18+72;
        width: 64;
        height: 64;
        Image {
            id: leftimg
            width:64
            height:64
            source: "./leftArrow.png"
        }
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

    Item{
        id:rightTurnRect
        x:1024-364-64;
        y:18+72;
        width: 64;
        height: 64;
        Image {
            id: rightimg
            width:64
            height:64
            source: "./rightArrow.png"
        }
    }
/*
    MainInfoPanel{
        id:mainInfoPanlel
        x:0;
        y:72;
    }*/

    SpeedPanel{
        id:speedPanel
        x:parent.width - width;
        y:(parent.height+72 -height)/2;
    }



    PowerPanel{
        id:rpmPanel
        x:0;
        y: (parent.height+72 -height)/2;
    }



    CanUtil{
        id:caninfoutil
        onSignalTest: {
            console.log("the num from signal is :",num);
            speedPanel.currentSpeed = num;
        }
    }

}

