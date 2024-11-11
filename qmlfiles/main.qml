
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

    CurvedRectangle{
        id:bottomRect
        width: 300
        height: 120
        color: "black"
        cornersRadius: [50,50,0,0]
        borderWidth: 5
        borderColor: "grey"
        x:(parent.width-width)/2;
        y:parent.height-120;

        Label {
            id: readyLabel
            text: qsTr("READY")
            color: "white"
            font.bold: true;
            font.pixelSize: 45
            x:(parent.width-width)/2
            y:10
        }
        Text {
            id: gearTxt
            text: qsTr("D")
            font.bold: true
            font.pixelSize: 65
            color: "#4ce600"
            x:(parent.width-width)/2
            y:50
        }
    }
    CanUtil{
        id:caninfoutil
        onSignalTest: {
            console.log("the num from signal is :",num);

        }
        onSignalSpeed: {
            mainPanel.speed = value;
        }
        onSignalGear: {
           gearTxt.text=value;
        }
        onSignalRpm: {

        }
        onSignalPower: {

        }
    }
}

