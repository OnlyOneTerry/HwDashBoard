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

    TurnLight{
        id:leftTurnLight
        x:200;
        y:18;
        source_path: "qrc:/img/leftArrow.png"
        on:true
    }

    TurnLight{
        id:rightTurnLight
        x:1024-200-width;
        y:18;
        source_path: "qrc:/img/rightArrow.png"
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
                    id: tripmile
                    text: qsTr("286.5")
                    font.pixelSize: 40
                    font.bold: false
                    color: "white"
                }
                Text {
                    id:tripunit
                    text: qsTr("km")
                    color: "white"
                    font.pixelSize: 18
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
                    text: qsTr("26792")
                    font.pixelSize: 40
                    font.bold: false
                    color: "white"
                }
                Text {
                    id:dodunit
                    text: qsTr("km")
                    color: "white"
                    font.pixelSize: 18
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
        id:rightGuage
        property bool accelerating
        width: 500
        height: 500
        x:(parent.width-width)/2
        y:-40
        value: speed;//accelerating ? maximumValue : 0
        maximumValue: 120
        Component.onCompleted: forceActiveFocus()
        Behavior on value { NumberAnimation { duration: 1000 }}
        Keys.onSpacePressed: leftGuage.accelerating = true
        Keys.onEnterPressed: rightGuage.accelerating = true
        Keys.onReturnPressed: rightGuage.accelerating = true

        Keys.onReleased: {
            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                rightGuage.accelerating = false;
                event.accepted = true;
            }else if (event.key === Qt.Key_Space) {
                leftGuage.accelerating = false;
                event.accepted = true;
            }
        }

        Timer{
            id:animationTimer
            interval: 500
            running: true
            repeat: true
            onTriggered: {
                rightGuage.value = Math.random()*120;
                rightGuage.chargeStatusIndex++;
                if(rightGuage.chargeStatusIndex>6)
                {
                    rightGuage.chargeStatusIndex = 0;
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
            source: "qrc:/img/far_light.png"
            width: 64
            height: 64
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
        }

        Image {
            id: batteryWarnImg
            source: "qrc:/img/power_battery_warning.png"
            width: 64
            height: 64
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
        }

        Image {
            id: limitPowerImg
            source: "qrc:/img/limit_power.png"
            width: 64
            height: 64
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


    Component.onCompleted: {
        rightGuage.accelerating = true;
    }

}
