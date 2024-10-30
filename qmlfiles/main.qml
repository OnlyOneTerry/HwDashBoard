
import QtQuick 2.12
import QtQuick.Controls 2.12
import CanUtil 1.0

ApplicationWindow {
    visible: true
    width: 1024
    height: 600
    title: "QtQuick Gauge Example"
    color: "#999";
    Head{
        id:headerPanel
        x:0;
        y:0;
    }

    MainInfoPanel{
        id:mainInfoPanlel
        x:0;
        y:72;
    }

    SpeedPanel{
        id:speedPanel
        x:parent.width - width;
        y:72;
    }

    PowerPanel{
        id:powerPanel
        x:parent.width - width;
        y:speedPanel.y+speedPanel.height;
    }

    CanUtil{
        id:caninfoutil
        onSignalTest: {
            console.log("the num from signal is :",num);
            speedPanel.testBool = true;
        }
    }

}

