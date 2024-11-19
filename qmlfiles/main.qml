
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

    Image {
        id: side_stand_img
        source: "qrc:/img/side_stand.png"
        width: 64
        height:64
        x:(parent.width-width)/2;
        y:195;
    }

    Label {
        id: readyLabel
        text: qsTr("READY")
        color: "white"
        font.bold: true;
        font.pixelSize: 45
        x:(parent.width-width)/2
        y:parent.height-128
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
            x:gearTxt.x+gearTxt.width+20;
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

        onSignalSpeed: {
            console.log("speed is :",value);
            moveSpeed = value.toFixed(1);
            mainPanel.middleGuage.speed = moveSpeed;
        }

        onSignalGear: {
            console.log("gear is :",value);
            showGear(value);
        }

        onSignalRpm: {
            console.log("rpm is :",value);
            mainPanel.middleGuage.value = value;
        }

        onSignalPower: {

        }

        onSignalReady:{
            console.log("ready is:",value);
            value ? readyLabel.color="#4ce600" : readyLabel.color="white";
        }

        onSignalRemainRange:
        {
            console.log("remained range is :",value);
            var remain = value;//Math.random() * 100;
            headerPanel.remainMile = remain.toFixed(2);
        }

        onSignalRightTurnOn:
        {
            console("right turn is:",value);
            mainPanel.rightTurnLight.on = value;
        }

        onSignalLeftTurnOn:
        {
            console.log("left turn is:",value);
            mainPanel.leftTurnLight.on = value;
        }

        onSignalBatSoc:
        { 
            console.log("soc is :",value);
            var soc = value ;//Math.random() * 100;
            soc = soc.toFixed(0);
            console.log("batsoc is:",soc);
            headerPanel.battery.batteryLevel = soc/100.0;
        }

        onSignalAutoHold: {
            console.log("AutoHold is:",value);
        }

        onSignalBatteryOverHotWarning: {
            console("batter is over hot:",value);
           mainPanel.is_battery_over_hot = value;
        }

        onSignalIsFarLight: {
            console.log("far light is:",value);
           mainPanel.is_far_light = value;
        }

        onSignalLimitPowerWarning:
        {
            console.log("limit power is :",value);
            mainPanel.is_limit_power = value;
        }

        onSignalBatteryWarning: {
            console.log("battery warning is:",value);
             mainPanel.is_battery_warning = value;
        }

        onSignalPluginIn: {
            console.log("plugged in is :",value);
             mainPanel.middleGuage.is_plugged_in = value;
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

