import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12
import QtCharts 2.3
import QtQuick.Particles 2.12
import QtQuick.Window 2.12

ApplicationWindow {
    id : appWindow
    visible: true
    width: 600
    height: 800
    header: Rectangle{
        id : hdr
        visible: false
        color: "black"
        height: 50
        RowLayout{
            anchors.fill: parent
            Image{
                Layout.fillHeight: true
                Layout.preferredWidth: 50
                fillMode: Image.PreserveAspectFit
                source: "qrc:/star2.png"
            }
            Label{
                id:stat
                text:"3"
                color: "yellow"
                font.pixelSize: 30
            }
            Label{
                text:"Личная статистика"
                color: "yellow"
                font.pixelSize: 30
            }
        }
    }

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
            hdr.visible = true;
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
        anchors.bottom: indicator.top

        Page{ // список команд
            background: Item{
                opacity: 0.2
            }

            PathView {
                id: pathView
                anchors.fill: parent
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
                        width: swipe.width-20
                        height: 150
                        Rectangle{
                            id : delegate
                            color: clr
                            opacity: 0.9
                            anchors.fill: parent
                            radius: 10

                            GridLayout{
                                anchors.fill: parent
                                anchors.margins: 5
                                rows: 4
                                columns: 3

                                rowSpacing : 3
                                Image{ // иконка команды
                                    Layout.fillHeight: true
                                    Layout.preferredWidth: delegate.height
                                    Layout.row: 0
                                    Layout.column: 0
                                    Layout.rowSpan: 3
                                    source: pict // иконка команды
                                    opacity: 0.8
                                }
                                Label{ // название команды
                                    Layout.row: 0
                                    Layout.column: 1
                                    Layout.columnSpan: 2
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 35
                                    text: team
                                    color: "white"
                                    font.family: "SWGothe"
                                    font.pixelSize: 30
                                    font.bold: true
                                }

                                Image{ // метрика 1
                                    source: (metr1>80)
                                            ?"qrc:/shield.png"
                                            :(metr1>70)
                                              ?"qrc:/banner.png"
                                              :"qrc:/sword.png"
                                    Layout.row: 1
                                    Layout.column: 1
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    fillMode: Image.PreserveAspectFit
                                    Label{
                                        anchors.fill: parent
                                        text: metr1
                                        font.pixelSize: 30
                                        font.bold: (metr1>80)?true:false
                                        color: (metr1>80)
                                               ?"green"
                                               :(metr1>70)?"yellow":"red"

                                    }
                                }
                                Image{ // метрика 2
                                    source: (metr2>80)
                                            ?"qrc:/shield.png"
                                            :(metr2>70)
                                              ?"qrc:/banner.png"
                                              :"qrc:/sword.png"
                                    Layout.row: 2
                                    Layout.column: 1
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    fillMode: Image.PreserveAspectFit
                                    Label{
                                    text: metr2
                                    font.pixelSize: 30
                                    font.bold: (metr2>80)?true:false
                                    color: (metr2>80)
                                           ?"green"
                                           :(metr2>70)?"yellow":"red"
                                    Layout.row: 1
                                    Layout.column: 1
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                }}
                                Image{ // метрика 3
                                    source: (metr3>80)
                                            ?"qrc:/shield.png"
                                            :(metr3>70)
                                              ?"qrc:/banner.png"
                                              :"qrc:/sword.png"
                                    Layout.row: 3
                                    Layout.column: 1
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    fillMode: Image.PreserveAspectFit
                                    Label{
                                    text: metr3
                                    font.pixelSize: 30
                                    font.bold: (metr3>80)?true:false
                                    color: (metr3>80)
                                           ?"green"
                                           :(metr3>70)?"yellow":"red"
                                    Layout.row: 2
                                    Layout.column: 1
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                }}
                                Image{ // метрика 4
                                    source: (metr4>80)
                                            ?"qrc:/shield.png"
                                            :(metr4>70)
                                              ?"qrc:/banner.png"
                                              :"qrc:/sword.png"
                                    Layout.row: 1
                                    Layout.column: 2
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    fillMode: Image.PreserveAspectFit
                                    Label{
                                    text: metr4
                                    font.pixelSize: 30
                                    font.bold: (metr4>80)?true:false
                                    color: (metr4>80)
                                           ?"green"
                                           :(metr4>70)?"yellow":"red"
                                    Layout.row: 0
                                    Layout.column: 2
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                }}
                                Image{ // метрика 5
                                    source: (metr5>80)
                                            ?"qrc:/shield.png"
                                            :(metr5>70)
                                              ?"qrc:/banner.png"
                                              :"qrc:/sword.png"
                                    Layout.row: 2
                                    Layout.column: 2
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    fillMode: Image.PreserveAspectFit
                                    Label{
                                    text: metr5
                                    font.pixelSize: 30
                                    font.bold: (metr5>80)?true:false
                                    color: (metr5>80)
                                           ?"green"
                                           :(metr5>70)?"yellow":"red"
                                    Layout.row: 1
                                    Layout.column: 2
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                }}
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
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                swipe.setCurrentIndex(1);
                            }
                        }
                    }
                path: Path {
                    startX: 50
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
                        x: -50;
                        y: appWindow.height;
                        controlX: 420;
                        controlY: appWindow.height/2 }
                    /*PathAttribute {
                        name: "iconScale";
                        value: 0.5 }*/
                }
            }

        }
        PageTeamStat {
            id: pageTeamStat
        }
        Page{ // магазин бонусов
            background: Item{
                opacity: 0.2
            }
            GridView{// бонусы
                id: shop
                anchors.fill: parent
                cellHeight: 150.0
                cellWidth : swipe.width/2 - 20
                clip: true

                model: ListModel{
                    ListElement{
                        name:"Выходной"
                        cost:2
                        pic:"qrc:/broken.png"
                    }
                    ListElement{
                        name:"День работы дома"
                        cost:1
                        pic:"qrc:/broken.png"
                    }
                    ListElement{
                        name:"Неделя на час раньше"
                        cost:1
                        pic:"qrc:/broken.png"
                    }
                    ListElement{
                        name:"Неделя такси"
                        cost:1
                        pic:"qrc:/taxi.png"
                    }
                    ListElement{
                        name:"Премия"
                        cost:1
                        pic:"qrc:/gold.png"
                    }
                }
                delegate: Item{
                    id : itmChest
                    height: shop.cellHeight
                    width: shop.cellWidth
                    Image{ // сундук
                        id : imgChest
                        anchors.fill: parent
                        source: (cost<2)?"qrc:/chest1.png":"qrc:/chest2.png"
                        fillMode: Image.PreserveAspectFit
                        GridLayout{
                            anchors.fill: parent
                            columns: 3
                            rows:3
                            Image{ // звёздочка в углу
                                Layout.column:0
                                Layout.row:0
                                Layout.preferredHeight: 30
                                Layout.preferredWidth: 30
                                fillMode: Image.PreserveAspectFit
                                source: "qrc:/star2.png"
                            }
                            Text{// стоимость бонуса
                               text:cost;
                               Layout.column:1
                               Layout.columnSpan: 2
                               Layout.row:0
                               font.pixelSize: 30
                               font.bold: true
                               color: "yellow"
                               horizontalAlignment:Text.AlignLeft
                            }
                            Image{// иконка бонуса
                                Layout.row:1
                                Layout.column:1
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                fillMode: Image.PreserveAspectFit
                                source: pic
                            }
                            Text{// название бонуса
                                Layout.row:2
                                Layout.column:1
                                Layout.columnSpan: 2
                                Layout.preferredHeight: 30
                                Layout.fillWidth: true
                                horizontalAlignment:Text.AlignHCenter
                                text:name
                                font.pixelSize: 20
                                font.bold: true
                                color: "yellow"
                            }
                        }
                    }
                    DropShadow {
                        id: shadow2
                        anchors.fill: imgChest
                        source: imgChest
                        horizontalOffset: 10
                        verticalOffset: 10
                        radius: 20
                        samples: 15
                        color: "black"
                        transparentBorder: true
                        opacity: 0.8
                    }
                    ParticleSystem {
                        id: particles
                        anchors.fill: parent
                        ImageParticle {
                            source: "qrc:/star.png"
                            alpha: 0
                            colorVariation: 0.6
                        }

                        Emitter {
                            id: burstEmitter
                            x: parent.width/2
                            y: parent.height/2
                            emitRate: 500
                            lifeSpan: 1000
                            enabled: false
                            velocity: AngleDirection{magnitude: 64; angleVariation: 360}
                            size: 50
                            sizeVariation: 20
                        }
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            if(stat.text > 0)
                            {
                                burstEmitter.pulse(500);//TODO вспышка
                                shopPath1.startX = 0.0;
                                shopPath1.startY = 0.0;
                                shopPath2.ext_x = itmChest.x + itmChest.width/2.0
                                shopPath2.ext_y = itmChest.y + itmChest.height/2.0
                                shopAnimation.start();
                                emitterTrail.pulse(1000);
                                --(stat.text);
                            }
                        }
                    }
                }
            }

        }
        PageRoulette {
            id: pageRoulette
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
                        "qrc:/ind3.png",
                        "qrc:/ind4.png"]
                    fillMode: Image.PreserveAspectFit
                    source: indicatorIcons[index]
                    anchors.fill: parent
                }
            }
    }

    RowLayout{ // нижняя панель навигации
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

                padding: 10
                contentItem:  Item{
                    anchors.margins: 10
                    Image{
                        id : imgTabBtn
                        anchors.fill: parent
                        source: modelData
                        fillMode: Image.PreserveAspectFit
                    }
                    Glow{
                        anchors.fill: imgTabBtn
                        radius: 8
                        samples: 17
                        color: "white"
                        source: imgTabBtn
                    }
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

    PathInterpolator { // анимация №1 магазина
        id : shopPath
        path: Path {
            id : shopPath1
            startX: 0.0
            startY: 0.0
            PathQuad {
                property real ext_x: 500
                property real ext_y: 500
                id: shopPath2
                x: ext_x
                y: ext_y
                controlX: ext_x / 3;
                controlY: ext_y * 2.0 / 3.0;
            }
        }
        NumberAnimation on progress {
            id : shopAnimation
            easing.type: Easing.InExpo
            running: false
            from: 0.0; to: 1.0;
            duration: 500
        }

    }

    Rectangle{ // спрайт анимации №1 магазина
        id : rctSprite
        color:"#00FFFFFF"
        x:shopPath.x
        y:shopPath.y
        width: 20
        height: 20
    }
    ParticleSystem { // след из частиц
        id: particlesShop1
        anchors.fill: parent
        //running: false
        ImageParticle {
            source: "qrc:/star.png"
            alpha: 0
            colorVariation: 0.6
        }

        Emitter {
            id: emitterTrail
            x: rctSprite.x + rctSprite.width/2
            y: rctSprite.y + rctSprite.height/2
            emitRate: 1000
            lifeSpan: 500
            enabled: false
            velocity: AngleDirection{magnitude: 10; angleVariation: 360}
            velocityFromMovement : 0.0
            size: 50
            sizeVariation: 20
        }
    }
}
