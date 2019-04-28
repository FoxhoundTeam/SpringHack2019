import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12
import QtCharts 2.3
ApplicationWindow {
    id : appWindow
    visible: true
    width: 600
    height: 800
    title: qsTr("Hello World")

    Timer{ // таймер анимации заставки
        id : startupTmr
        interval : 2000
        running : true
        repeat: false
        triggeredOnStart : false
        onTriggered: {
            // начать анимацию
            stop();
            blurAnimation.start();
            opacityAnimation.start();
            opacityAnimation1.start();
            opacityAnimation2.start();
            opacityAnimation2.start();
            opacityAnimation3.start();
        }
    }

    Image{ // железный трон
        id : imgBack
        anchors.fill: parent

        source: "qrc:/NoqcEgG.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    Image{ // "Game of ..."
        id : imgSplashUpper
        source: "qrc:/gameofsprints.png"
        fillMode: Image.PreserveAspectFit
        anchors.centerIn: parent
        width: parent.width - 50
        height: 250
        visible: false
    }
    Glow {
        id : txtSplashUpper
        //anchors.fill: indImage
        radius:20
        samples: 17
        color: "white"
        source: imgSplashUpper
        anchors.fill: imgSplashUpper
        anchors.margins: 0
    }

    Image{ // "... is coming"
        id : txtSplashLower
        width: parent.width - 50
        source:"qrc:/deadlineiscoming.png"
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 50
        fillMode: Image.PreserveAspectFit
    }

    NumberAnimation { // сделать видимым GUI
        id : opacityAnimation
        targets: [swipe,indicator]
        property : "opacity"
        running: false
        duration: 500
        from: 0.0; to: 0.8
    }
    NumberAnimation { // сделать видимым TabBar
        id : opacityAnimation1
        target: tabBar
        property : "opacity"
        running: false
        duration: 500
        from: 0.0; to: 1.0
    }
    NumberAnimation { // размыть back
        id : blurAnimation
        target: blurBack
        property : "radius"
        running: false
        duration: 500
        from: 0; to: 16
    }  
    NumberAnimation { // спрятать splash-надписи
        id : opacityAnimation2
        targets: [txtSplashUpper, txtSplashLower, blurSplash2, blurSplash1]
        properties : "opacity"
        running: false
        duration: 500
        from: 1; to: 0
    }
    NumberAnimation { // размыть splash-надписи
        id : opacityAnimation3
        targets: [blurSplash2, blurSplash1]
        properties : "radius"
        running: false
        duration: 490
        from: 0; to: 100
    }

    FastBlur { // размытие железного трона
        id : blurBack
        anchors.fill: imgBack
        source: imgBack
        radius: 0
    }
    FastBlur { // размытие нижней надписи
        id : blurSplash1
        anchors.fill: txtSplashLower
        source: txtSplashLower
        radius: 0
    }
    FastBlur { // размытие верхней надписи
        id : blurSplash2
        anchors.fill: txtSplashUpper
        source: txtSplashUpper
        radius: 0
    }

    SwipeView{
        id: swipe
        opacity: 0.0

        anchors.top: parent.top
        width: parent.width
        //anchors.left: parent.left
        //anchors.right: parent.right
        anchors.bottom: indicator.top

        Page{ // список команд
            //opacity: 0.5
            background: Item{
                opacity: 0.2
            }

            PathView {
                id: pathView
                //opacity: 0.5
                anchors.fill: parent
                //highlight: appHighlight
                preferredHighlightBegin: 0.5
                preferredHighlightEnd: 0.5
                focus: true
                clip: true
                model: ListModel{
                    ListElement{//1
                        team:"Бек-разработка"
                        pict:"qrc:/1_1.png"
                        clr:"#FF010101"
                        metr1 : 94
                        metr2 : 66
                        metr3 : 97
                        metr4 : 78
                        metr5 : 63
                    }
                    ListElement{//2
                        team:"Фронт-разработка"
                        pict:"qrc:/2_2.png"
                        clr:"#FFDDDDDD"
                        metr1 : 61
                        metr2 : 52
                        metr3 : 68
                        metr4 : 88
                        metr5 : 64
                    }
                    ListElement{//3
                        team:"Маркетинг"
                        pict:"qrc:/3_3.png"
                        clr:"#FF9A1324"
                        metr1 : 84
                        metr2 : 67
                        metr3 : 65
                        metr4 : 97
                        metr5 : 99
                    }
                    ListElement{//4
                        team:"Техподдержка"
                        pict:"qrc:/4_4.png"
                        clr:"#FF002E72"
                        metr1 : 66
                        metr2 : 95
                        metr3 : 71
                        metr4 : 98
                        metr5 : 60
                    }
                    ListElement{//5
                        team:"Тестировщики"
                        pict:"qrc:/5_5.png"
                        clr:"#FFFED700"
                        metr1 : 54
                        metr2 : 56
                        metr3 : 83
                        metr4 : 70
                        metr5 : 88
                    }
                }

                delegate:
                    Item{
                        width: 500
                        height: 150
                        Rectangle{
                            id : delegate
                            color: clr
                            opacity: 0.9
                            width: 500
                            height: 150
                            radius: 10

                            GridLayout{
                                anchors.fill: parent
                                rows: 3
                                columns: 3
                                Image{ // иконка команды
                                    Layout.fillHeight: true
                                    Layout.preferredWidth: delegate.height
                                    Layout.row: 0
                                    Layout.column: 0
                                    Layout.rowSpan: 3
                                    source: pict // иконка команды
                                    opacity: 0.8
                                }
                                Label{
                                    text: metr1
                                    font.pixelSize: 40
                                    font.bold: (metr1>80)?true:false
                                    color: (metr1>80)
                                           ?"green"
                                           :(metr1>70)?"yellow":"red"
                                    Layout.row: 0
                                    Layout.column: 1
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                }
                                Label{
                                    text: metr2
                                    font.pixelSize: 40
                                    font.bold: (metr2>80)?true:false
                                    color: (metr2>80)
                                           ?"green"
                                           :(metr2>70)?"yellow":"red"
                                    Layout.row: 1
                                    Layout.column: 1
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                }
                                Label{
                                    text: metr3
                                    font.pixelSize: 40
                                    font.bold: (metr3>80)?true:false
                                    color: (metr3>80)
                                           ?"green"
                                           :(metr3>70)?"yellow":"red"
                                    Layout.row: 2
                                    Layout.column: 1
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                }
                                Label{
                                    text: metr4
                                    font.pixelSize: 40
                                    font.bold: (metr4>80)?true:false
                                    color: (metr4>80)
                                           ?"green"
                                           :(metr4>70)?"yellow":"red"
                                    Layout.row: 0
                                    Layout.column: 2
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                }
                                Label{
                                    text: metr5
                                    font.pixelSize: 40
                                    font.bold: (metr5>80)?true:false
                                    color: (metr5>80)
                                           ?"green"
                                           :(metr5>70)?"yellow":"red"
                                    Layout.row: 1
                                    Layout.column: 2
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                }
                            }
                        }

                        DropShadow {
                            id: shadow
                            anchors.fill: delegate
                            source: delegate
                            horizontalOffset: 10
                            verticalOffset: 10
                            radius: 20
                            samples: 15
                            color: "black"
                            transparentBorder: true
                            opacity: 0.8
                        }
                    }
                path: Path {
                    startX: 200
                    startY: 0
                    /*PathAttribute {
                        name: "iconScale";
                        value: 0.5 }
                    PathQuad {
                        x: 200;
                        y: appWindow.height/2;
                        controlX: 0;
                        controlY: 100 }
                    PathAttribute {
                        name: "iconScale";
                        value: 1.0 }*/
                    PathQuad {
                        x: 100;
                        y: appWindow.height;
                        controlX: 450;
                        controlY: appWindow.height/2 }
                    /*PathAttribute {
                        name: "iconScale";
                        value: 0.5 }*/
                }
            }

        }
        Page{ // статистика команды
            ChartView {
                anchors.fill: parent
                //theme: ChartView.ChartThemeBrownSand
                //antialiasing: true
                BarSeries {
                    id: mySeries
                    axisX: BarCategoryAxis { categories: ["%усп.тст.", "%усп.сб.", "задачи", "комм", "%покр."] }
                    BarSet { label: "Бек-разработка"; values: [80, 60, 50, 90, 80] }
                }
            }
        }
        Page{ // магазин бонусов
            GridView{// бонусы

            }
        }
        Page{ // рулетка

        }
    }

    PageIndicator {
        id: indicator
        opacity: 0.0
        count: swipe.count
        currentIndex: swipe.currentIndex
        height: 30
        anchors.bottom: tabBar.top
        //width: parent.width
        anchors.horizontalCenter:
            parent.horizontalCenter

        delegate:
            Glow {
                //anchors.fill: indImage
                radius:(index==swipe.currentIndex) ?10:0;
                samples: 17
                color: "white"
                source: indImage
                width: 30
                height: 30
                Image {
                    id: indImage
                    property var indicatorIcons:
                        ["qrc:/ind1.png",
                        "qrc:/ind2.png",
                        "qrc:/ind3.png"]
                    fillMode: Image.PreserveAspectFit
                    source: indicatorIcons[index]
                    anchors.fill: parent
                }
            }

    }

    RowLayout{
        id : tabBar
        width: parent.width
        height: 100
        anchors.bottom: parent.bottom
        opacity: 0.0
        Repeater{
            model: ["qrc:/button1.png",
                "qrc:/button2.png",
                "qrc:/button3.png"]
            delegate: Button{
                id : tabBtnDelegate
                Layout.fillHeight: true
                Layout.preferredWidth: tabBar.width/3

                /*background:Image{
                    anchors.fill: parent
                    anchors.margins: 0
                    source: modelData
                    fillMode: Image.PreserveAspectFit
                }*/
                padding: 10
                contentItem:  Image{
                    //anchors.fill: parent
                    anchors.margins: 10
                    source: modelData

                    //height: 50
                    //width: width
                    fillMode: Image.PreserveAspectFit
                }
                background: Image{
                    source: (swipe.currentIndex==index)
                            ?"qrc:/fire.png":""
                    fillMode: Image.Stretch
                }

                onClicked: {
                    swipe.currentIndex= index
                }
            }
        }
    }
}
