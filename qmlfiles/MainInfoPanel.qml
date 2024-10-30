import QtQuick 2.0

Rectangle {
    id:root
    width: 764;
    height: 528;
    color:"#999";
    property color bgcolor:"#999";
    property int mileage: 231
    property int totalmileage:2321
    Rectangle{
        id:leftTurnRect
        x:71;
        y:18;
        width: 64;
        height: 64;
        color:bgcolor
        Image {
            id: leftimg
            width:64
            height:64
            source: "./leftArrow.png"
        }
    }

    Rectangle{
        id:dayLight
        x:71
        y:leftTurnRect.y+width+10;
        width: 64;
        height: 64;
        color: "red"
        Image {
            id: daylightImg
            width:64
            height:64
            //source: "./qmlfiles/leftArrow.png"
        }
    }

    Rectangle{
        id:locationLight
        x:71
        y:dayLight.y+width+10;
        width: 64;
        height: 64;
        color: "red"
        Image {
            id: locationlightImg
            width:64
            height:64
            //source: "./leftArrow.png"
        }
    }

    Rectangle{
        id:nearFarLight
        x:71
        y:locationLight.y+width+10;
        width: 64;
        height: 64;
        color: "red"
        Image {
            id: nearfarlightImg
            width:64
            height:64
            //source: "./leftArrow.png"
        }
    }

    Rectangle{
        id:brakeLight
        x:71
        y:nearFarLight.y+width+10;
        width: 64;
        height: 64;
        color: "red"
        Image {
            id: brakeLightImg
            width:64
            height:64
            //source: "./leftArrow.png"
        }
    }

    Rectangle{
        id:mileageRect
        color:bgcolor
        x:71
        y:root.height-height-10
        width: 300
        height: 50
        Text {
            id: mileageTxt
            color: "white"
            font.pixelSize: 32
            font.weight: Font.Bold
            verticalAlignment: Text.AlignVCenter
            text: qsTr("Mileage:")+mileage+("km")
        }

        Text {
            id: totalmileageTxt
            color: "white"
            font.pixelSize: 32
            font.weight: Font.Bold
            x:mileageTxt.x+mileageTxt.width+100
            verticalAlignment: Text.AlignVCenter
            text: qsTr("Total:")+totalmileage+"km"
        }

    }

    Rectangle{
        id:gearRect
        x:(root.width-width)/2
        y:18
        width: 47
        height:47
        color:bgcolor
        Text {
            id: gearTxt
            color: "white"
            font.pixelSize: 52
            font.weight: Font.Bold
            text: qsTr("D")
        }
    }

    Rectangle{
        id:reserve0
        x:gearRect.x-64-10
        y:gearRect.y+width+10;
        width: 64;
        height: 64;
        color: "red"
        Image {
            id: reserve0LightImg
            width:64
            height:64
            //source: "./leftArrow.png"
        }
    }

    Rectangle{
        id:reserve1
        x:reserve0.x+reserve0.width+ 10
        y:gearRect.y+width+10;
        width: 64;
        height: 64;
        color: "red"
        Image {
            id: reserve1LightImg
            width:64
            height:64
            //source: "./leftArrow.png"
        }
    }

    Rectangle{
        id:reserve2
        x:reserve1.x+reserve1.width+ 10
        y:gearRect.y+width+10;
        width: 64;
        height: 64;
        color: "red"
        Image {
            id: reserve2LightImg
            width:64
            height:64
            //source: "./leftArrow.png"
        }
    }

    Rectangle{
        id:speedArea
        x:(root.width-speedArea.width)/2
        y:reserve2.y+reserve2.height+10
        width: 253
        height: 253
        radius: width
        color:"#eee"
        Text {
            id: speedTxt
            x:(speedArea.width-speedTxt.width)/2
            y:(speedArea.height-speedTxt.height)/2-20
            text: qsTr("235")
            font.pixelSize: 82
            font.weight: Font.Bold
        }

        Text {
            id: unitTxt
            x:(speedArea.width-unitTxt.width)/2
            y:speedTxt.y+speedTxt.height+10
            text: qsTr("km/h")
            font.pixelSize: 42
            font.weight: Font.Bold
        }
    }

    Rectangle{
        id:rightTurnRect
        x:586;
        y:18;
        width: 64;
        height: 64;
        color:bgcolor
        Image {
            id: rightimg
            width:64
            height:64
            source: "./rightArrow.png"
        }
    }

    Rectangle{
        id:reserve3
        x:rightTurnRect.x;
        y:rightTurnRect.y+rightTurnRect.height+10;
        width: 64;
        height: 64;
        color:"red"
        Image {
            id: reserve3img
            width:64
            height:64
            //source: "./rightArrow.png"
        }
    }
    Rectangle{
        id:reserve4
        x:reserve3.x;
        y:reserve3.y+reserve3.height+10;
        width: 64;
        height: 64;
        color:"red"
        Image {
            id: reserve4img
            width:64
            height:64
            //source: "./rightArrow.png"
        }
    }

    Rectangle{
        id:reserve5
        x:reserve4.x;
        y:reserve4.y+reserve4.height+10;
        width: 64;
        height: 64;
        color:"red"
        Image {
            id: reserve5img
            width:64
            height:64
            //source: "./rightArrow.png"
        }
    }
    Rectangle{
        id:reserve6
        x:reserve5.x;
        y:reserve5.y+reserve5.height+10;
        width: 64;
        height: 64;
        color:"red"
        Image {
            id: reserve6img
            width:64
            height:64
            //source: "./rightArrow.png"
        }
    }

    Rectangle{
        id:reserve7
        x:rightTurnRect.x+width+10;
        y:rightTurnRect.y+reserve7.height+10;
        width: 64;
        height: 64;
        color:"red"
        Image {
            id: reserve7img
            width:64
            height:64
            //source: "./rightArrow.png"
        }
    }

    Rectangle{
        id:reserve8
        x:reserve7.x;
        y:reserve7.y+reserve8.height+10;
        width: 64;
        height: 64;
        color:"red"
        Image {
            id: reserve8img
            width:64
            height:64
            //source: "./rightArrow.png"
        }
    }

    Rectangle{
        id:reserve9
        x:reserve8.x;
        y:reserve8.y+reserve9.height+10;
        width: 64;
        height: 64;
        color:"red"
        Image {
            id: reserve9img
            width:64
            height:64
            //source: "./rightArrow.png"
        }
    }

    Rectangle{
        id:reserve10
        x:reserve9.x;
        y:reserve9.y+reserve10.height+10;
        width: 64;
        height: 64;
        color:"red"
        Image {
            id: reserve10img
            width:64
            height:64
            //source: "./rightArrow.png"
        }
    }

    Rectangle{
        id:modeRect
        x:reserve6.x;
        y:reserve6.y+reserve6.height+10
        width: 138;
        height:64;
        color:"red"
        Text {
            id: modeTxt
            text: qsTr("Mode")
            font.pixelSize: 42
            font.weight: Font.Bold
            color: "white"
            anchors.centerIn: parent
        }

    }

}
