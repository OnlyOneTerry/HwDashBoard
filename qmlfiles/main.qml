
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtGraphicalEffects 1.0
import CanUtil 1.0
import QtQuick.Layouts 1.3
import QtQuick.Extras.Private 1.0

ApplicationWindow {
    visible: true
    width: 1024
    height: 600
    title: "QtQuick Gauge Example"
    color: "black";
    property real moveSpeed : 1.0
    property real singleDistance: 0

    Head{
        id:headerPanel
        x:0;
        y:0;
    }

    MainInfoPanel{
        id:mainPanel
        x:0
        y:72
    }

    Label {
        id: readyLabel
        text: qsTr("READY")
        color: "white"
        font.bold: true;
        font.pixelSize: 45
        x:(parent.width-width)/2
        y:parent.height-125
    }

    CurvedRectangle{
        id:bottomRect
        width: 300
        height:80
        color: "black"
        cornersRadius: [50,50,0,0]
        borderWidth: 5
        borderColor: "grey"
        x:(parent.width-width)/2;
        y:parent.height-80;
        property alias readyLabel: readyLabel

        Text {
            id: gearTxt
            text: qsTr("P")
            font.bold: true
            font.pixelSize: 65
            color: "#4ce600"
            x:20
            y:10//50
        }
        Text {
            id: gear0
            text: qsTr("0")
            font.bold: true
            font.pixelSize: 65
            color: "#ffffff"
            x:gearTxt.x+gearTxt.width+20;//(parent.width-width)/2
            y:10
        }
        Text {
            id: gear1
            text: qsTr("1")
            font.bold: true
            font.pixelSize: 65
            color: "#ffffff"
            x:gear0.x+gear0.width+20
            y:10
        }
        Text {
            id: gear2
            text: qsTr("2")
            font.bold: true
            font.pixelSize: 65
            color: "#ffffff"
            x:gear1.x+gear1.width+20
            y:10
        }
        Text {
            id: gear3
            text: qsTr("3")
            font.bold: true
            font.pixelSize: 65
            color: "#ffffff"
            x:gear2.x+gear2.width+20
            y:10
        }
    }

    function showGearModeIndex(index)
    {
        switch(index)
        {
        case 0:
            gear0.color="green";
            gear1.color="white";
            gear2.color="white";
            gear3.color="white";
            break;
        case 1:
            gear0.color="white";
            gear1.color="green";
            gear2.color="white";
            gear3.color="white";
            break;
        case 2:
            gear0.color="white";
            gear1.color="white";
            gear2.color="green";
            gear3.color="white";
            break;
        case 3:
            gear0.color="white";
            gear1.color="white";
            gear2.color="white";
            gear3.color="green";
            break;
        }
    }

    function showGear(index)
    {
        switch(index)
        {
        case 0:
            gearTxt.text ="D";
            break;
        case 1:
            gearTxt.text ="F";
            break;
        case 2:
            gearTxt.text ="R";
            break;
        case 3:
            gearTxt.text ="N";
            break;
        }
    }

    CanUtil{
        id:caninfoutil
        onSignalTest: {
            console.log("the num from signal is :",num);

        }

        onSignalSpeed: {
            moveSpeed = value.toFixed(1);
            mainPanel.middleGuage.speed = moveSpeed;
        }

        onSignalGear: {
            showGear(value);
        }

        onSignalRpm: {
            mainPanel.middleGuage.rpm = value;
        }

        onSignalPower: {

        }

        onSignalReady:{
            value ? bottomRect.readyLabel.color="green" : bottomRect.readyLabel.color="white";
        }

        onSignalRemainRange:
        {
            headerPanel.remainMile = value;
        }

        onSignalRightTurnOn:
        {
            mainPanel.rightTurnLight.on = value;
        }

        onSignalLeftTurnOn:
        {
            mainPanel.leftTurnLight.on = value;
        }

        onSignalBatSoc:
        {
            console.log("batsoc is:",value);
            headerPanel.battery.batteryLevel = value/100.0;
        }
    }

    Timer{
        id:updateMile
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            var sp = moveSpeed/3600;
            mainPanel.tripmile +=sp;
            mainPanel.tripmile =mainPanel.tripmile.toFixed(2);
            mainPanel.odomile +=sp;
            mainPanel.odomile = mainPanel.odomile.toFixed(2);
            GlobalEnv.setTotalMiles(mainPanel.odomile);
        }
    }

    Component.onCompleted: {
        var total = GlobalEnv.getTotalMiles();
        console.log("totalmile is :",total);
        mainPanel.odomile = total.toFixed(2);

    }
}

