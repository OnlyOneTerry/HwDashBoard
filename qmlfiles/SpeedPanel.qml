import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtGraphicalEffects 1.0

Item {
    id:root
    width: 364;
    height: 364;
    //color:"#999"
     property int currentSpeed: 0
    // 圆形的表盘背景
    Rectangle {
        id:speedRect
        width: 364
        height: 364
        radius: width / 2
        color: "#000"
        border.color: "#000"
        border.width: 4
        antialiasing: true;
        x:parent.width - width;
        CircularGauge {
            id: spPanel
            value: currentSpeed;
            anchors.centerIn: parent
            maximumValue: 200
            width: height
            height: parent.height
            style: DashboardGaugeStyle {}
            // 动画效果
            Behavior on value {
                NumberAnimation { duration: 600; easing.type: Easing.InOutQuad }
            }
        }

    }
}
