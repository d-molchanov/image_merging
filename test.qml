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
            Layout.alignment: Qt.AlignHCenter
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

        Item {

            Layout.fillWidth: true
            Layout.leftMargin: 10

            Layout.minimumHeight: 140
            RowLayout {
                id: rwLt
                anchors.fill: parent
                spacing: 10

                ColumnLayout{
                    Layout.fillWidth: true
                    spacing: 0
                    Item {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 20
                        Label {
                            text: qsTr("Suffixes")
                            color: systemPalette.windowText
                            anchors.centerIn: parent

                        }
                    }

                    Item {
                        Layout.fillWidth: true
                        Layout.minimumHeight: 100
                        Layout.preferredHeight: 100
                        ScrollView {
                            id: scvSufficesNew
                            width: parent.width
                            height: 100
                            ScrollBar.vertical.policy: ScrollBar.AsNeeded
                            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                            
                            TextArea {
                                id: tarSufficesNew
                                width: parent.width
                                height: parent.height
                                wrapMode: TextEdit.Wrap

                                placeholderText: qsTr("This is Suffixes")
                            }
                        }
                    }

                    Item {
                        Layout.fillHeight: true
                    }

                }

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    
                    GroupBox {
                        anchors.fill: parent
                        title: qsTr("Extensions")
                        ScrollView {
                            id: scvExtensionsNew
                            width: parent.width
                            height: 100
                            ScrollBar.vertical.policy: ScrollBar.AsNeeded
                            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                            
                            TextArea {
                                id: tarExtensionsNew
                                width: parent.width
                                height: parent.height
                                wrapMode: TextEdit.Wrap

                                placeholderText: qsTr("This is Extensions")
                                        
                            }
                        }
                    }
                }
            }
        }

        Label {
                text: qsTr("Logs:")
                color: systemPalette.windowText
        }

        Item {
            Layout.fillWidth: true
            Layout.minimumHeight: 50
            Layout.preferredHeight: 50
            Layout.margins: 10
            ScrollView {
                id: scvSuffices
                width: parent.width
                height: 50
                ScrollBar.vertical.policy: ScrollBar.AsNeeded
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                
                TextArea {
                    id: tarSuffices
                    width: parent.width
                    height: parent.height
                    wrapMode: TextEdit.Wrap

                    placeholderText: qsTr("This is logs")
                    
                }

            }
        }

        Item {

            Layout.fillWidth: true
            Layout.margins: 10

            Layout.minimumHeight: 20
            RowLayout {
                anchors.fill: parent
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: systemPalette.highlightedText
                    TextEdit {
                        // selectionColor: systemPalette.highlight
                        selectionColor: systemPalette.accent
                        width: parent.width
                        anchors.verticalCenter: parent.verticalCenter
                        // palette.base: "#FF0000"
                        // palette.text: "#ffff00"
                        text: qsTr("Hello!")

                    }
                }

                Button {
                    text: qsTr("Select directory")
                }

                Button {
                    text: qsTr("Merge images")
                }
            }
        }

        Item {

            Layout.fillWidth: true
            Layout.margins: 10

            Layout.minimumHeight: 20
            RowLayout {
                anchors.fill: parent
                id: root
                ComboBox {
                    Layout.fillWidth: true
                    id: cbDirection
                    currentIndex: 0
                    model: ListModel {
                        ListElement { text: qsTr("Horizontal") }
                        ListElement { text: qsTr("Vertical") }
                    }

                    onCurrentIndexChanged: {
                        root.updateAlignmentModel()
                    }

                    // onCurrentIndexChanged: {
                    //     console.debug(cbDirection.get(currentIndex).text)
                    //     if (cbDirection.currentIndex === 0) {
                    //         cbAlignment.model = ["Left", "Center", "Right"]
                    //     } else { // Vertical
                    //         cbAlignment.model = ["Top", "Center", "Bottom"]
                    //     }
                    // }
                }

                ComboBox {
                    Layout.fillWidth: true
                    id: cbAlignment
                    currentIndex: 0
                    // model: ListModel {
                    //     ListElement { text: qsTr("Top") }
                    //     ListElement { text: qsTr("Center") }
                    //     ListElement { text: qsTr("Down") }
                    // }
                    model: ["Left", "Center", "Right"]
                }

                function updateAlignmentModel() {
                    console.debug(cbAlignment.model)
                    if (cbDirection.currentIndex === 0) {
                        cbAlignment.model = ["Left", "Center", "Right"]
                    } else { // Vertical
                        cbAlignment.model = ["Top", "Center", "Bottom"]
                    }
                }
            }
        }

        Item {
            Layout.fillHeight: true
        }

    }
}
