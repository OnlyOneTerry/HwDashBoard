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
                    text: qsTr("mile\nkm")
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
                    text: qsTr("mile\nkm")
                    color: "white"
                    font.pixelSize: 18
                }
                x:(parent.width-width)/2;
                y:(parent.height-height)/2-20;
            }
            Text {
                id: dodtag
                text: qsTr("DOD")
                font.pixelSize: 40
                font.bold: true
                color: "white"
                x:(parent.width-width)/2;
                y:(parent.height-height)-20;
            }
        }
    }

//    SpeedPanel{
//        width: 400
//        height: 400
//        x:(parent.width-width)/2
//        y:10
//    }

    CustomCircleGauge{
        id:rightGuage
        property bool accelerating
        width: 400
        height: 400
        x:(parent.width-width)/2
        y:10
        value: accelerating ? maximumValue : 0
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
    }

    Component.onCompleted: {
        rightGuage.accelerating = true;
    }

}
