import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0
//import PyOtherSide for Android
import io.thp.pyotherside 1.4

ApplicationWindow {
    id: appWindow
    visible: true
    //Action Bar at the top of the screen needs to be dynamically named
    menuBar: MenuBar {
        id: topMenu
        Menu {
            MenuItem {
                text: qsTr("&About")
            }
            MenuItem {
                text: qsTr("&Reload")
            }
        }
    }

    Rectangle{
        id: mainView
        anchors.top: topMenu.bottom
        anchors.fill: parent
        //Item for dislpaying the Items from Iserv
        Component{
            id: vertretungsplanItem
            Item{
                height: 300
                id:itemsrc
                Rectangle{
                    id: rect
                    color: "transparent"
                    border.width: 6
                    border.color: "black"
                    Item {

                        Column{
                            Text{ text:""}

                            Text{ text: "<b>Klasse:</b> " + klasse}

                            Text{ text: "<b>Stunde:</b> " + stunde}

                            Text{ text: "<b>Vertreter</b> " + vertreter}

                            Text{ text: "<b>Lehrer:</b> " + lehrer}

                            Text{ text: "<b>Raum:</b> " + raum}
                        }
                     }
                }
            }
        }

        ListView {
            id: view
            clip: true
            anchors.fill: parent

            model: ListModel{
                id: vertretungsplanModel
            }
            delegate: vertretungsplanItem
        }
    }


    Python {
           id: py

           Component.onCompleted: {
               // Add the directory of this .qml file to the search path
               addImportPath(Qt.resolvedUrl('.'));
               // Import the main module and load the data
               importModule('listmodel', function () {
                   py.call('listmodel.get_data', [], function(result) {
                       // Load the received data into the list model
                       for (var i=0; i<result.length; i++) {
                           vertretungsplanModel.append(result[i]);
                       }
                   });
               });
           }
       }
 }
