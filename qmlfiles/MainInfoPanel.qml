import QtQuick 2.0
import QtQuick.Window 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import CanUtil 1.0

Item {
    id:root
    width: 1024;
    height: 528;
    property real speed: 20
    property alias leftTurnLight: leftTurnLight
    property alias rightTurnLight:rightTurnLight
    property alias middleGuage: middleGuage
    property real tripmile :0
    property real odomile: 0
    property bool is_far_light: false
    property bool  is_limit_power: false
    property bool  is_drive_warning: false
    property bool  is_battery_warning: false
    property bool  is_battery_over_hot: false
    property bool  is_coolant_insufficient: false
    property bool  is_tire_warning: false
    property bool  is_left_turn: false
    property bool  is_right_turn:false;

    TurnLight{
        id:leftTurnLight
        x:200;
        y:18;
        source_path: "qrc:/img/leftArrow.png"
        on:is_left_turn
    }

    TurnLight{
        id:rightTurnLight
        x:1024-200-width;
        y:18;
        source_path: "qrc:/img/rightArrow.png"
        on:is_right_turn
    }

    DashedCircle{
        id:trip
        x:20
        y:60
        width: 220
        height: 220
        cirleSegmentCount:4

        Item{
            id:txtArea
            width: parent.width-70
            height: parent.height-70
            anchors.centerIn: parent
            Row{
                Text {
                    id: tripMile
                    text:tripmile
                    font.pixelSize: 40
                    font.bold: true
                    color: "white"
                }
                Text {
                    id:tripunit
                    text: qsTr("km")
                    color: "white"
                    font.bold: true
                    font.pixelSize: 22
                }
                x:(parent.width-width)/2;
                y:(parent.height-height)/2-20;
            }
            Text {
                id: triptag
                text: qsTr("TRIP")
                font.pixelSize: 40
                font.bold: true
                color: "white"
                x:(parent.width-width)/2;
                y:(parent.height-height)-20;
            }
        }
    }

    DashedCircle{
        id:dod
        x:parent.width-width-20
        y:60
        width: 220
        height: 220
        cirleSegmentCount:8

        Item{
            id:txtDod
            width: parent.width-70
            height: parent.height-70
            anchors.centerIn: parent
            Row{
                Text {
                    id: dodmile
                    text:odomile
                    font.pixelSize: 40
                    font.bold: true
                    color: "white"
                }
                Text {
                    id:dodunit
                    text: qsTr("km")
                    color: "white"
                    font.bold: true
                    font.pixelSize: 22
                }
                x:(parent.width-width)/2;
                y:(parent.height-height)/2-20;
            }
            Text {
                id: dodtag
                text: qsTr("ODO")
                font.pixelSize: 40
                font.bold: true
                color: "white"
                x:(parent.width-width)/2;
                y:(parent.height-height)-20;
            }
        }
    }

    CustomCircleGauge{
        id:middleGuage
        property bool accelerating
        width: 500
        height: 500
        x:(parent.width-width)/2
        y:-45
        value: 0;
        maximumValue: 120
        Component.onCompleted: forceActiveFocus()
        Behavior on value { NumberAnimation { duration: 1000 }}
        Timer{
            id:animationTimer
            interval: 500
            running: false
            repeat: true
            onTriggered: {
                middleGuage.value = Math.random()*120;
                //test animation
                middleGuage.chargeStatusIndex++;
                if(middleGuage.chargeStatusIndex>6)
                {
                    middleGuage.chargeStatusIndex = 0;
                }
            }
        }
    }

    Image {
        id: leftbg
        source: "qrc:/img/leftbg.png"
        x:0
        y:300
        width: 300
        height:188
    }

    Image {
        id: rightbg
        source: "qrc:/img/rightbg.png"
        x:1024-300
        y:300
        width: 300
        height:188
    }

    Row {
        id: leftupRow
        spacing: 50
        x:30
        y:350
        Image {
            id: farlightImg
            source: is_far_light ?"qrc:/img/far_light.png":"qrc:/img/near_light.png"
            width: 64
            height: 64
            visible: false;
        }

        Image {
            id: locationLight
            source: "qrc:/img/location_light.png"
            width: 64
            height: 64
        }
    }

    Row {
        id: rightupRow
        spacing: 50
        x:810
        y:350
        Image {
            id: engineImg
            source: "qrc:/img/drive_sys_warning.png"
            width: 64
            height: 64
            visible: is_drive_warning;
        }

        Image {
            id: autoholdImg
            source: "qrc:/img/auto_hold.png"
            width: 64
            height: 64
        }
    }


    Row {
        id: leftdownRow
        spacing: 50
        x:30
        y:430
        Image {
            id: insufficientCoolantImg
            source: "qrc:/img/insufficient_coolant.png"
            width: 64
            height: 64
            visible: is_coolant_insufficient
        }

        Image {
            id: batteryWarnImg
            source: "qrc:/img/power_battery_warning.png"
            width: 64
            height: 64
            visible: is_battery_warning;
        }
    }

    Row {
        id: rightdownRow
        spacing: 50
        x:810
        y:440
        Image {
            id: tirePressImg
            source: "qrc:/img/tire_pressure_warning.png"
            width: 64
            height: 64
            visible: is_tire_warning
        }

        Image {
            id: limitPowerImg
            source: "qrc:/img/limit_power.png"
            width: 64
            height: 64
            visible: is_limit_power;
        }
    }

    Rectangle{
        id:leftSplitLine
        width: 230
        height: 2
        x:20
        y:420
        border.color: "white"
    }


    Rectangle{
        id:rightSplitLine
        width: 230
        height: 2
        x:1024-250
        y:420
        border.color: "white"
    }
}
