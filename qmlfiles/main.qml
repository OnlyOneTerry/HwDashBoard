
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
        visible: false;
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
            color: "#bbbbbb"
            x:gearTxt.x+gearTxt.width+20;
            y:10
            visible: false
        }
        Text {
            id: gear1
            text: qsTr("1")
            font.bold: true
            font.pixelSize: 65
            color: "#bbbbbb"
            x:gear0.x+gear0.width+20
            y:10
        }
        Text {
            id: gear2
            text: qsTr("2")
            font.bold: true
            font.pixelSize: 65
            color: "#bbbbbb"
            x:gear1.x+gear1.width+20
            y:10
        }
        Text {
            id: gear3
            text: qsTr("3")
            font.bold: true
            font.pixelSize: 65
            color: "#bbbbbb"
            x:gear2.x+gear2.width+20
            y:10
        }
    }

    function showGearModeIndex(index)
    {
        switch(index)
        {
        case 0:
            gear0.color="#4ce600";
            gear1.color="#bbbbbb";
            gear2.color="#bbbbbb";
            gear3.color="#bbbbbb";
            break;
        case 1:
            gear0.color="#bbbbbb";
            gear1.color="#4ce600";
            gear2.color="#bbbbbb";
            gear3.color="#bbbbbb";
            break;
        case 2:
            gear0.color="#bbbbbb";
            gear1.color="#bbbbbb";
            gear2.color="#4ce600";
            gear3.color="#bbbbbb";
            break;
        case 3:
            gear0.color="#bbbbbb";
            gear1.color="#bbbbbb";
            gear2.color="#bbbbbb";
            gear3.color="#4ce600";
            break;
        default:
            gear0.color="#bbbbbb";
            gear1.color="#bbbbbb";
            gear2.color="#bbbbbb";
            gear3.color="#bbbbbb";
            break;
        }
    }

    function showGear(index)
    {
        switch(index)
        {
        case 0:
            gearTxt.text ="N";
            break;
        case 1:
        case 2:
        case 3:
            gearTxt.text ="D";
            break;
        case 100:
            gearTxt.text = "R";
            break;
        }
        showGearModeIndex(index);
    }

    CanUtil{
        id:caninfoutil

        onSignalSpeed: {
            console.log("speed is :",value);
            moveSpeed = value.toFixed(1);
            mainPanel.middleGuage.speed = moveSpeed;
        }

//        onSignalGearMode: {
//            console.log("three gear set is :",value);
//            var index = value;
//            showGear(index);
//        }

        onSignalGear: {
            console.log("three gear set is :",value);
            var index = value;
            showGear(index);
        }

        onSignalRpm: {
            console.log("rpm is :",value);
            var rpm = value;
            mainPanel.middleGuage.value = rpm/100.0*10;//note: gauge has divided 10
        }

        onSignalPower: {
           console.log("power is :",value);
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

        onSignalTotalMileage: {
            console.log("total is :",value);
            var total =value ;
            mainPanel.odomile = total.toFixed(1);
        }

        onSignalTripMileage: {
            var trip = value;
            console.log("trip is :",trip);
            mainPanel.tripmile =trip.toFixed(1);
        }

        onSignalTime: {
          console.log("time :",value);
          headerPanel.time = value;
        }

        onSignalSideStandDrop:{
           console.log("side stand drop is :",value);
           var is_drop = value;
           side_stand_img.visible = is_drop===1;

        }

        onSignalKIneEnergyRecovery:{
             console.log("kinetic_energy_ercovery :",value);
        }
        onSignalPGear: {
            console.log("P gear :",value);
            if(value===1)
            {
                gearTxt.text="P";
            }
        }


    }

    Timer{
        id:updateMile
        interval: 1000
        repeat: true
        running: false
        onTriggered: {
            var sp = moveSpeed/3600;
            mainPanel.tripmile +=sp;
            mainPanel.tripmile =mainPanel.tripmile.toFixed(1);
            mainPanel.odomile +=sp;
            mainPanel.odomile = mainPanel.odomile.toFixed(1);
            GlobalEnv.setTotalMiles(mainPanel.odomile);
        }
    }

    Component.onCompleted: {
        var total = GlobalEnv.getTotalMiles();
        console.log("totalmile is :",total);
        mainPanel.odomile = total.toFixed(1);

    }

}

