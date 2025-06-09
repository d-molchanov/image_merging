import QtCore
import QtQuick
import QtQuick.Window
// import QtQuick.Controls.Basic
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

        Item {
            // Layout: {
            //     fillWidth: true
            //     leftMargin: 10
            //     rightMargin: 10
            //     minimumHeight: 140
            // }
            Layout.fillWidth: true
            Layout.leftMargin: 10
            Layout.rightMargin: 10

            Layout.minimumHeight: 140
            RowLayout {
                id: rwLt
                anchors.fill: parent
                spacing: 10

                // ColumnLayout{
                //     Layout.fillWidth: true
                //     spacing: 0
                //     Item {
                //         Layout.fillWidth: true
                //         Layout.preferredHeight: 20
                //         Label {
                //             text: qsTr("Suffixes")
                //             color: systemPalette.windowText
                //             anchors.centerIn: parent

                //         }
                //     }

                //     Item {
                //         Layout.fillWidth: true
                //         Layout.minimumHeight: 100
                //         Layout.preferredHeight: 100
                //         ScrollView {
                //             id: scvSufficesNew
                //             width: parent.width
                //             height: 100
                //             ScrollBar.vertical.policy: ScrollBar.AsNeeded
                //             ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                            
                //             TextArea {
                //                 id: tarSufficesNew
                //                 width: parent.width
                //                 height: parent.height
                //                 wrapMode: TextEdit.Wrap

                //                 placeholderText: qsTr("This is Suffixes")
                //             }
                //         }
                //     }

                //     Item {
                //         Layout.fillHeight: true
                //     }

                // }

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    
                    GroupBox {
                        anchors.fill: parent
                        title: qsTr("Suffixes")
                        ScrollView {
                            id: scrollViewSuffixes
                            width: parent.width
                            height: 100
                            ScrollBar.vertical.policy: ScrollBar.AsNeeded
                            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                            
                            TextArea {
                                id: textAreaSuffixes
                                width: parent.width
                                height: parent.height
                                wrapMode: TextEdit.Wrap
                                text: qsTr("_main _profile _профиль")
                                placeholderText: qsTr("Ex.:\n_main\n_profile\netc.")
                                        
                            }
                        }
                    }
                }

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    
                    GroupBox {
                        anchors.fill: parent
                        title: qsTr("Extensions")
                        ScrollView {
                            id: scrollViewExtensions
                            width: parent.width
                            height: 100
                            ScrollBar.vertical.policy: ScrollBar.AsNeeded
                            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                            
                            TextArea {
                                id: textAreaExtensions
                                width: parent.width
                                height: parent.height
                                wrapMode: TextEdit.Wrap
                                text: qsTr(".png\n\n.jpg")
                                placeholderText: qsTr("Ex.:\n.png\n.jpg\netc.")
                                        
                            }
                        }
                    }
                }

                Item {

                    Layout.fillHeight: true
                    // Layout.minimumHeight: 20
                    Layout.preferredWidth: 120
                    // Layout.margins: 10

                    GroupBox {
                        anchors.fill: parent
                        // height: parent.height
                        title: qsTr("Alignment")

                        ColumnLayout {
                            anchors.fill: parent
                            id: root
                            ComboBox {
                                // Layout.fillHeight: true
                                id: cbDirection
                                currentIndex: 0
                                Layout.preferredWidth: 100
                                model: ListModel {
                                    ListElement { text: qsTr("Horizontal") }
                                    ListElement { text: qsTr("Vertical") }
                                }

                                onCurrentIndexChanged: {
                                    root.updateAlignmentModel()
                                }
                            }

                            ComboBox {
                                // Layout.fillHeight: true
                                id: cbAlignment
                                currentIndex: 1
                                Layout.preferredWidth: 100
                                // model: ["Left", "Center", "Right"]
                                model: ["Top", "Center", "Bottom"]
                            }

                            Item {
                                Layout.fillHeight: true
                            }

                            function updateAlignmentModel() {
                                console.debug(cbAlignment.model)
                                if (cbDirection.currentIndex === 1) {
                                    cbAlignment.model = ["Left", "Center", "Right"]
                                } else { // Vertical
                                    cbAlignment.model = ["Top", "Center", "Bottom"]
                                }
                                cbAlignment.currentIndex = 1
                                // console.debug(StandardPaths.applicationDirPath)
                            }
                        }
                    }
                }

                // Item {
                //     Layout.fillHeight: true
                // }
            }
        }

        // Label {
        //         text: qsTr("Logs:")
        //         color: systemPalette.windowText
        // }
        Item {
            Layout.fillWidth: true
            Layout.leftMargin: 10
            Layout.rightMargin: 10
            Layout.minimumHeight: 64
            GroupBox {
                anchors.fill: parent
                title: qsTr("Output image parameters")
                id: groupBoxImageParameters
                RowLayout {
                    anchors.fill: parent

                    Label {
                        text: qsTr("Quality:")
                        color: systemPalette.windowText
                    }

                    // TextField {
                    //     id: textFieldQuality
                    //     width: 32
                    //     placeholderText: qsTr("Quality")
                    // }

                    SpinBox {
                        id: spinBoxQuality
                        from: 1
                        to: 100
                        value: 75
                        editable: true
                        Layout.preferredWidth: 56
                        // width: 100

                    }


                    Label {
                        text: qsTr("Color:")
                        color: systemPalette.windowText
                    }

                    TextField {
                        id: textFieldColor
                        Layout.preferredWidth: 64
                        placeholderText: qsTr("Ex.: #ffffff for white")
                        text: "#ffffff"
                        validator: RegularExpressionValidator { 
                            regularExpression: /^#[0-9A-Fa-f]{6}$/
                        }

                        // textFromValue: function(value) {
                        //     return '#' + value
                        // }

                        // valueFromText: function(text, locale) {
                        //     let re = /^#[0-9A-Fa-f]{6}$/
                        //     return re.exec(text)[1]
                        // }
                    }

                    Label {
                        text: qsTr("Result file extension:")
                        color: systemPalette.windowText
                    }

                    ComboBox {
                        id: comboBoxResultExtension
                        currentIndex: 0
                        Layout.preferredWidth: 48
                        model: [".jpg", ".png"]

                        onCurrentIndexChanged: {
                            groupBoxImageParameters.updateSpinBoxQuality()
                        }
                    }

                    Switch {
                        id: switchSubdirectories
                        text: qsTr("Subdirectories")
                        // Text {
                        //     text: qsTr("Subdirectories")
                        //     color: "#ffffff"
                        // }
                        // contentItem: Text {
                        //     color: systemPalette.windowText
                        // }
                        // color: systemPalette.windowText
                        palette {
                            // buttonText: systemPalette.windowText
                            buttonText: "#ffffff"
                        }
                        onClicked: {
                            console.debug(switchSubdirectories.checked)
                        }
                    }

                    // Switch {
                    //     id: control
                    //     text: qsTr("Switch")

                    //     indicator: Rectangle {
                    //         implicitWidth: 48
                    //         implicitHeight: 26
                    //         x: control.leftPadding
                    //         y: parent.height / 2 - height / 2
                    //         radius: 13
                    //         color: control.checked ? "#17a81a" : "#ffffff"
                    //         border.color: control.checked ? "#17a81a" : "#cccccc"

                    //         Rectangle {
                    //             x: control.checked ? parent.width - width : 0
                    //             width: 26
                    //             height: 26
                    //             radius: 13
                    //             color: control.down ? "#cccccc" : "#ffffff"
                    //             border.color: control.checked ? (control.down ? "#17a81a" : "#21be2b") : "#999999"
                    //         }
                    //     }

                    //     contentItem: Text {
                    //         text: control.text
                    //         font: control.font
                    //         opacity: enabled ? 1.0 : 0.3
                    //         color: control.down ? "#17a81a" : "#21be2b"
                    //         verticalAlignment: Text.AlignVCenter
                    //         leftPadding: control.indicator.width + control.spacing
                    //     }
                    // }

                    Item {
                        Layout.fillWidth: true
                    }
                }

                function updateSpinBoxQuality() {
                    // console.debug(cbAlignment.model)
                    if (comboBoxResultExtension.currentIndex === 0) {
                        spinBoxQuality.to = 100
                        spinBoxQuality.value = 75                        
                    } else { // Vertical
                        spinBoxQuality.to = 9
                        spinBoxQuality.value = 7
                    }
                    // console.debug(StandardPaths.applicationDirPath)
                }

            }

        }
        

        Item {

            Layout.fillWidth: true
            Layout.margins: 10

            Layout.minimumHeight: 32
            RowLayout {
                anchors.fill: parent
                
                TextField {
                    id: textFieldDirectory
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignVCenter
                    // Layout.fillHeight: true
                    // palette.base: systemPalette.window
                    // width: parent.width
                    // anchors.verticalCenter: parent.verticalCenter
                    // anchors.left: parent.left
                    // anchors.leftMargin: 10
                    placeholderText: qsTr("Type or select via button ->")
                    // text: qsTr("/home/dmitry/Projects/python/(2025_05_25)_image_merger/test")
                    text: qsTr("D:/MIPT/Projects/20250519_Image_Merging/test")

                }
                

                Button {
                    id: btnSelectDirectory

                    padding: 10
                    text: qsTr("Select directory")
                    Layout.fillHeight: true
                    onClicked: folderDialog.open()
                    hoverEnabled: true
                    ToolTip.delay: 1000
                    ToolTip.timeout: 5000
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("Select directory")
                }

                FolderDialog {
                    id: folderDialog
                    currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
                    // currentFolder: StandardPaths.applicationDirPath
                    // flags: FolderDialog.ShowDirsOnly
                    onAccepted: {
                        let url = folderDialog.selectedFolder
                        let nativePath = Qt.resolvedUrl(url).toString().replace("file:///", "")
                        textFieldDirectory.text = nativePath
                        console.debug(nativePath)
                   }
                }  

                Button {
                    padding: 6
                    text: qsTr("Merge images")
                    Layout.fillHeight: true
                    enabled: textFieldDirectory.text.trim() !== "" && textAreaSuffixes.text.trim() !== "" && textAreaExtensions.text.trim()
                    onClicked: {
                        backend.text = textFieldDirectory.text
                        backend.get_target_directory(textFieldDirectory.text)
                        backend.get_suffixes(textAreaSuffixes.text)
                        backend.get_extensions(textAreaExtensions.text)
                        backend.get_direction(cbDirection.currentText)
                        backend.get_alignment(cbAlignment.currentText)
                        console.debug(cbAlignment.currentText)
                        backend.merge_images()
                        // backend.print_text(textFieldDirectory.text)
                    }

                }

                Connections {
                    target: backend
                    function onLogsUpdated(log) {
                        // textAreaLogs.text = log
                        textAreaLogs.append(log)
                    }
                }
            }
        }



        

        Item {
            Layout.fillWidth: true
            Layout.minimumHeight: 50
            Layout.preferredHeight: 50
            Layout.leftMargin: 10
            Layout.rightMargin: 10
            ScrollView {
                id: scrollViewLogs
                width: parent.width
                height: 100
                ScrollBar.vertical.policy: ScrollBar.AsNeeded
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                
                TextArea {
                    id: textAreaLogs
                    width: parent.width
                    height: parent.height
                    wrapMode: TextEdit.Wrap

                    placeholderText: qsTr("This is logs")
                    
                }

            }
        }

        Item {
            Layout.fillHeight: true
        }

        // Item {

        //     Layout.fillWidth: true
        //     Layout.margins: 10

        //     Layout.minimumHeight: 20
        //     RowLayout {
        //         anchors.fill: parent
        //         id: root
        //         ComboBox {
        //             Layout.fillWidth: true
        //             id: cbDirection
        //             currentIndex: 0
        //             model: ListModel {
        //                 ListElement { text: qsTr("Horizontal") }
        //                 ListElement { text: qsTr("Vertical") }
        //             }

        //             onCurrentIndexChanged: {
        //                 root.updateAlignmentModel()
        //             }

        //             // onCurrentIndexChanged: {
        //             //     console.debug(cbDirection.get(currentIndex).text)
        //             //     if (cbDirection.currentIndex === 0) {
        //             //         cbAlignment.model = ["Left", "Center", "Right"]
        //             //     } else { // Vertical
        //             //         cbAlignment.model = ["Top", "Center", "Bottom"]
        //             //     }
        //             // }
        //         }

        //         ComboBox {
        //             Layout.fillWidth: true
        //             id: cbAlignment
        //             currentIndex: 0
        //             // model: ListModel {
        //             //     ListElement { text: qsTr("Top") }
        //             //     ListElement { text: qsTr("Center") }
        //             //     ListElement { text: qsTr("Down") }
        //             // }
        //             model: ["Left", "Center", "Right"]
        //         }

        //         function updateAlignmentModel() {
        //             console.debug(cbAlignment.model)
        //             if (cbDirection.currentIndex === 0) {
        //                 cbAlignment.model = ["Left", "Center", "Right"]
        //             } else { // Vertical
        //                 cbAlignment.model = ["Top", "Center", "Bottom"]
        //             }
        //         }
        //     }
        // }

        // Item {
        //     Layout.fillHeight: true
        // }

    }
}
