import QtCore
import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Image Merger ver. 0.1")

    color: systemPalette.window
    SystemPalette {
        id: systemPalette
    }


    ColumnLayout {
        anchors.fill: parent
        spacing: 10


        Button {
            id: btnSelectDirectory
            Layout.alignment: Qt.AlignCenter
            text: qsTr("Select directory")
            onClicked: folderDialog.open()
            hoverEnabled: true
            ToolTip.delay: 1000
            ToolTip.timeout: 5000
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Select directory")
        }

        FolderDialog {
            id: folderDialog
            currentFolder: "."
        }

        RowLayout {
            // Layout.alignment: 
            ColumnLayout {
                Layout.fillWidth: true
                
                Label {
                    id: lblSuffixes
                    anchors.top: btnSelectDirectory.botton
                    text: qsTr("Suffixes")

                }

                // Rectangle {
                //     border.color: "#000000"
                //     border.width: 1
                //     width: tarSuffices.width
                //     height: tarSuffices.height

                    ScrollView {
                        
                        id: scvSuffices
                        width: parent.windth
                        height: 50
                        TextArea {
                            id: tarSuffices
                            width: parent.width
                            height: parent.height
                            placeholderText: qsTr("Enter suffices")
                            
                        }

                    }
                // }

            }

            // ColumnLayout {
            //     Layout.fillWidth: true

            //     Label {
            //         id: lblExtensions
            //         text: qsTr("Extensions")
            //     }

            //     TextArea {
            //         id: tarExtensions
            //         placeholderText: qsTr("Enter extensions")
            //         // Layout.maximumHeight: 200
            //         // flickable: true
            //         // ScrollBar.vertical.policy: ScrollBar.AsNeeded
            //         ScrollView {
            //             id: scvExtensions

            //             ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            //             ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            //         }
            //     }
            // }

        }

        Label {
            text: qsTr("Logs:")
        }

        ScrollView {
            Layout.fillWidth: true
            ScrollBar.vertical.policy: ScrollBar.AsNeeded
            height: 50
            clip: true
            contentHeight: tarLogs.height
            
            TextArea {
                id: tarLogs
                height: 50
                wrapMode: TextEdit.Wrap
            }

        }

        Item {
            Layout.fillHeight: true
        }
    }

}