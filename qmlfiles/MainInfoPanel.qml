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
        source_path: "./leftArrow.png"
        on:true
    }

    TurnLight{
        id:rightTurnLight
        x:1024-200-width;
        y:18;
        source_path: "./rightArrow.png"
    }

    DashedCircle{
        x:20
        y:60
        width: 200
        height: 200
        cirleSegmentCount:4
    }

    DashedCircle{
        x:parent.width-width-20
        y:60
        width: 200
        height: 200
        cirleSegmentCount:8
    }

    CustomCircleGauge{
        id:rightGuage
        property bool accelerating
        width: 400
        height: 400
        x:(parent.width-width)/2
        y:10
        value: accelerating ? maximumValue : 0
        maximumValue: 180
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
