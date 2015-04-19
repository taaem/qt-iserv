import QtQuick 2.3
import io.thp.pyotherside 1.4
import QtQuick.Controls 1.2
import Qt.labs.settings 1.0

Item{
    id: mainView
    //Item for dislpaying the Items from Iserv
    Component{
        id: vertretungsplanItem
        Item{
            height: 250
            width: parent.width
            anchors.topMargin: 20
            id:itemsrc
            Column{
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter:parent.horizontalCenter

                Text{ text: "<b>Klasse:</b> " + klasse; font.pixelSize: 32}

                Text{ text: "<b>Stunde:</b> " + stunde; font.pixelSize: 32}

                Text{ text: "<b>Vertreter</b> " + vertreter; font.pixelSize: 32}

                Text{ text: "<b>Lehrer:</b> " + lehrer; font.pixelSize: 32}

                Text{ text: "<b>Raum:</b> " + raum; font.pixelSize: 32}
            }
            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 15
                height: 1
                color: "black"
            }
        }
    }

    ListView {
        id: view
        clip: true
        anchors.fill: parent
        header: Item{
            height: 88
            anchors.horizontalCenter:parent.horizontalCenter
            Button{
                anchors.horizontalCenter:parent.horizontalCenter
                text: "Aktualisieren"
                onClicked: {
                    // Delete old ListView
                    vertretungsplanModel.clear()
                    // Change Actionbar Text to Loading
                    actionText.text = "Laden..."
                    py.call('listmodel.get_data', [settings.username, settings.password], function(result){
                    // Load the received data into the list model
                    for (var i=0; i<result.length; i++) {
                        vertretungsplanModel.append(result[i]);
                    }})

                }
            }
        }

        model: ListModel{
            id: vertretungsplanModel
        }
        delegate: vertretungsplanItem
    }
    Python {
           id: py

           Component.onCompleted: {
               setHandler("date_received", function(date){
                    actionText.text = date;
               })
               // Add the directory of this .qml file to the search path
               addImportPath(Qt.resolvedUrl('.'));
               // Import the main module and load the data
               importModule('listmodel', function () {
                   py.call('listmodel.get_data', [settings.username, settings.password], function(result){
                       // Load the received data into the list model
                       for (var i=0; i<result.length; i++) {
                           vertretungsplanModel.append(result[i]);
                       }
                   });
               });
           }
       }


}

