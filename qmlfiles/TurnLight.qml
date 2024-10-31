import QtQuick 2.0

Item{
    id:turnlight
    width: 64;
    height: 64;

    property bool isLeft: true
    property bool  on: false
    property bool  isFlash: false;
    property string source_path:""
    Image {
        id: leftimg
        width:64
        height:64
        source: source_path
    }

    Timer {
        interval: 500; running: on; repeat: true
        onTriggered: {
            isFlash=!isFlash;
            leftimg.visible = isFlash
        }
    }
}
