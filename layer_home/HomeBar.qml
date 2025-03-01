import QtQuick 2.15
import QtGraphicalEffects 1.12
import "../global"
import "../Lists"
import "../utils.js" as Utils
import "qrc:/qmlutils" as PegasusUtils


ListView {
    id: homeLayout
    //anchors.fill: parent
    property int _index: 0
    spacing: vpx(14)
    orientation: ListView.Horizontal
    
    displayMarginBeginning: vpx(107)
    displayMarginEnd: vpx(107)

    preferredHighlightBegin: vpx(0)
    preferredHighlightEnd: vpx(1077)
    highlightRangeMode: ListView.StrictlyEnforceRange // Highlight never moves outside the range
    snapMode: ListView.SnapToItem
    highlightMoveDuration: 100
    highlightMoveVelocity: -1
    keyNavigationWraps: true
    
    NumberAnimation { id: anim; property: "scale"; to: 0.7; duration: 100 }

    model: gamesListModel
    delegate: homeBarDelegate

    Component {
        id: homeBarDelegate
        Rectangle {
            id: wrapper

            property bool selected: ListView.isCurrentItem
            property var gameData: searchtext ? modelData : listRecent.currentGame(idx)
            property bool isGame: idx >= 0

            onGameDataChanged: { if (selected) updateData() }
            onSelectedChanged: { if (selected) updateData() }

            function updateData() {
                currentGame = gameData;
                currentScreenID = idx;
            }

            width: homeLayout.height//isGame ? homeLayout.height : homeLayout.height*0.7
            height: width
            color: "transparent"

            anchors.verticalCenter: parent.verticalCenter

            Rectangle{
                id: background
                width: isGame ? homeLayout.height : homeLayout.height*0.7
                height: width
                radius: isGame ? 0 : width
                opacity: 1
                color: theme.button
                layer.enabled: enableDropShadows && !selected //TODO turn off when highlighted
                layer.effect: DropShadow {
                    transparentBorder: true
                    horizontalOffset: 0
                    verticalOffset: 0
                    color: "#4D000000"
                    radius: 3.0
                    samples: 6
                    z: -2
                }
                
                anchors.centerIn: parent
                
            }

            // Preference order for Game Backgrounds
            property var gameBG: {
                return getGameBackground(gameData, settings.gameBackground);
            }

            Image {
                id: gameImage
                width: isGame ? homeLayout.height : homeLayout.height*0.7//.width
                height: width
                smooth: true
                fillMode: (gameBG == gameData.assets.boxFront) ? Image.PreserveAspectFit : Image.PreserveAspectCrop
                source: gameBG // gameData.collections.get(0).shortName === "steam" ? gameData.assets.screenshot : gameBG
                asynchronous: true
                sourceSize { width: 256; height: 256 }
                
                anchors.centerIn: parent

                Rectangle {
                    id: favicon
                    anchors { 
                        right: parent.right; rightMargin: vpx(5); 
                        top: parent.top; topMargin: vpx(5) 
                    }
                    width: vpx(32)
                    height: width
                    radius: width/2
                    color: theme.accent
                    visible: isGame ? gameData.favorite : false
                    Image {
                        id: faviconImage
                        source: "../assets/images/heart_filled.png"
                        asynchronous: true
                        anchors.fill: parent
                        anchors.margins: vpx(7)            
                    }
                    
                    ColorOverlay {
                        anchors.fill: faviconImage
                        source: faviconImage
                        color: "white" //theme.icon
                        antialiasing: true
                        smooth: true
                        cached: true
                    }
                }
                
            }

            //white overlay on screenshot for better logo visibility over screenshot
            Rectangle {
                width: gameImage.width
                height: gameImage.height
                color: "white"
                opacity: 0.15
                visible: logo.source != "" && gameImage.source != ""
            }

            Image {
                id: logo

                anchors.fill: gameImage
                anchors.centerIn: gameImage
                anchors.margins: isGame ? vpx(30) : vpx(60)
                property var logoImage: {
                    if (gameData != null) {
                        if (gameData.collections.get(0).shortName === "retropie")
                            return "";//gameData.assets.boxFront;
                        else if (gameData.collections.get(0).shortName === "steam")
                            return Utils.logo(gameData) ? Utils.logo(gameData) : "" //root.logo(gameData);
                        else if (gameData.assets.tile != "")
                            return "";
                        else if (gameBG == gameData.assets.boxFront)
                            return "";
                        else
                            return gameData.assets.logo;
                    } else {
                        return ""
                    }
                }

                source: gameData ? logoImage : icon //Utils.logo(gameData)
                sourceSize: Qt.size(gameImage.width, gameImage.height)
                fillMode: Image.PreserveAspectFit
                asynchronous: true
                smooth: true
                visible: gameData.assets.logo && gameBG != gameData.assets.boxFront ? true : false
                // z: 10
            }

            ColorOverlay {
                anchors.fill: logo
                source: logo
                color: theme.icon
                antialiasing: true
                cached: true
                visible: !isGame
            }


            Text
            {
                text: idx > -1 ? gameData.title : name
                width: gameImage.width
                horizontalAlignment : Text.AlignHCenter
                font.family: titleFont.name
                color: theme.text
                font.pixelSize: Math.round(screenheight*0.025)
                font.bold: true

                anchors.centerIn: gameImage
                wrapMode: Text.Wrap
                visible: logo.source == "" && gameImage.source == ""
                z: 10
            }

            MouseArea {
                anchors.fill: gameImage
                hoverEnabled: true
                onEntered: {}
                onExited: {}
                onClicked: {
                    if (selected)
                    {
                        if (currentIndex == softCount) {
                            gotoSoftware();
                        } else {
                            anim.start();
                            playGame();//launchGame(currentGame);
                        }
                    }
                    else
                        navSound.play();
                        homeSwitcher.currentIndex = index
                        homeSwitcher.focus = true
                        buttonMenu.focus = false

                }
            }

            Text {
                id: topTitle
                text: idx > -1 ? gameData.title : name
                color: theme.accent
                font.family: titleFont.name
                font.pixelSize: Math.round(screenheight*0.035)
                font.weight: Font.DemiBold
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                //clip: true
                //elide: Text.ElideRight

                anchors {
                    horizontalCenter: gameImage.horizontalCenter
                    bottom: gameImage.top; bottomMargin: Math.round(screenheight*0.025)
                }

                opacity: wrapper.ListView.isCurrentItem ? 1 : 0
                Behavior on opacity { NumberAnimation { duration: 75 } }
            }

            Component.onCompleted: {
                if (wordWrap) {
                    if (topTitle.paintedWidth > gameImage.width * 1.70) {
                        topTitle.width = gameImage.width * 1.5
                    }
                }
            }

            HighlightBorder
            {
                id: highlightBorder
                width: gameImage.width + vpx(18)//vpx(274)
                height: width//vpx(274)
                
                anchors.centerIn: parent
                

                x: vpx(-9)
                y: vpx(-9)
                z: -1

                selected: wrapper.ListView.isCurrentItem
            }

        }
    }

    Keys.onLeftPressed: {
        navSound.play();
        decrementCurrentIndex();
    }
    Keys.onRightPressed: {
        navSound.play();
        incrementCurrentIndex();
    }

    Keys.onUpPressed:{
        borderSfx.play();
    }

    Keys.onDownPressed: {
        _index = currentIndex;
        navSound.play();
        themeButton.focus = true
        homeSwitcher.currentIndex = -1
    }

    function gotoSoftware()
    {
            showSoftwareScreen();
    }


    //TODO Software screen is always at index 12, but would hopefully not exist/be visible if there are less than 12 titles
    Keys.onPressed: {
        if (api.keys.isAccept(event) && !event.isAutoRepeat) {
            event.accepted = true;
            if (currentIndex == softCount) {
                gotoSoftware();
            } else {
                anim.start();
                playGame();//launchGame(currentGame);
            }
        }

        if (api.keys.isDetails(event)) {
            event.accepted = true;
            if (currentGame.favorite){
                turnOffSfx.play();
            }
            else {
                turnOnSfx.play();
            }
            currentGame.favorite = !currentGame.favorite
            return;
        }
    }

    
}

