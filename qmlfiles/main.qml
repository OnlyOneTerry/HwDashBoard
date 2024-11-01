
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
        x:0
        y:72
    }

    CanUtil{
        id:caninfoutil
        onSignalTest: {
            console.log("the num from signal is :",num);
        }
    }

}

