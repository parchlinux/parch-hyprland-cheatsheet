import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io

ShellRoot {
    FloatingWindow {
        id: win
        title: "Welcome to ParchLinux Hyprland"
        implicitWidth: 640
        implicitHeight: 460
        color: "transparent"

        readonly property color cBg:        "#202124" 
        readonly property color cSurface:   "#292a2d"
        readonly property color cChip:      "#3c4043"
        readonly property color cOutline:   "#5f6368"
        readonly property color cOnSurface: "#e8eaed"
        readonly property color cSubtext:   "#9aa0a6"

        readonly property string fontMain: "Google Sans"

        property string scriptPath: "/opt/parch-hyprland-cheatsheet/cheatsheet.qml"
        property string hyprConfPath: Quickshell.env("HOME") + "/.config/hypr/hyprland.lua"
        readonly property string autostartLine:'hl.exec_cmd("qs -p ' + win.scriptPath + '")'
        readonly property string autostartBlock: 'hl.on("hyprland.start", function()' + autostartLine + '' + 'end)'

        property bool autostartEnabled: false

        Process {
            id: checkAutostart
            command: ["grep","-qF",'hl.exec_cmd("qs -p ' + win.scriptPath + '")',win.hyprConfPath]
            running: true

            onExited: (code) => {
                win.autostartEnabled = (code === 0)
            }
        }

        Process {
            id: enableAutostart
            command: ["bash", "-c", 'printf "%s" "$1" >> "$2"', "_", win.autostartBlock,win.hyprConfPath]
        }

        Process {
            id: disableAutostart
            command: ["bash", "-c", 'BLOCK="$1" perl -0777 -pi -e \'s/\\Q$ENV{BLOCK}\\E//\' "$2"', "_", win.autostartBlock,win.hyprConfPath]
        }

        function setAutostart(enabled) {
            win.autostartEnabled = enabled

            if (enabled) {
                enableAutostart.running = true
            } else {
                disableAutostart.running = true
            }
        }


        property var binds: [
            { combo: ["SUPER", "Q"],        desc: "Open terminal" },
            { combo: ["SUPER", "E"],              desc: "Open file manager" },
            { combo: ["SUPER", "R"],              desc: "Open app launcher" },
            { combo: ["SUPER", "C"],              desc: "Close active window" },
            { combo: ["SUPER", "V"],              desc: "Toggle floating window" },
            { combo: ["SUPER", "1‑9"],            desc: "Switch to workspace" },
            { combo: ["SUPER", "SHIFT", "1‑9"],   desc: "Move window to workspace" },
            { combo: ["SUPER", "SHIFT", "1-9"], desc: "Move active window" },
            { combo: ["SUPER", "Mouse Right"],    desc: "Resize window (drag)" },
            { combo: ["CTRL", "SHIFT", "S"],      desc: "Screenshot (selection)" },
            { combo: ["CTRL", "S"],               desc: "Screenshot (full screen)" }
        ]
        property var links: [
            { label: "Website", url: "https:/parchlinux.com"},
            { label: "Forum",   url: "https://forum.parchlinux.com" },
            { label: "Wiki",    url: "https://wiki.parchlinux.com" },
            { label: "GitHub",  url: "https://github.com/parchlinux" },
            { label: "discord", url: "https://discord.gg/6B6YUr9zzP"}
        ]
        function firstHalf() {
            const half = Math.ceil(win.binds.length / 2)
            return win.binds.slice(0, half)
        }
        function secondHalf() {
            const half = Math.ceil(win.binds.length / 2)
            return win.binds.slice(half)
        }

        Rectangle {
            anchors.fill: parent
            color: win.cBg

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 24
                spacing: 16

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 10

                    Image {
                        source: "icon.svg"
                        Layout.preferredWidth: 32
                        Layout.preferredHeight: 32
                        fillMode: Image.PreserveAspectFit
                        sourceSize.width: 32
                        sourceSize.height: 32
                    }

                    Text {
                        text: "Welcome to ParchLinux Hyprland"
                        color: win.cOnSurface
                        font.family: win.fontMain
                        font.pixelSize: 22
                        font.weight: Font.Medium
                    }
                }
                Text {
                    text: "Hyprland Keybind Cheatsheet"
                    color: win.cSubtext
                    font.family: win.fontMain
                    font.pixelSize: 13
                }

                Rectangle { Layout.fillWidth: true; height: 1; color: win.cOutline; opacity: 0.5 }

                RowLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.topMargin: 4
                    spacing: 40

                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignTop
                        spacing: 14

                        Repeater {
                            model: win.firstHalf()
                            delegate: BindRow {}
                        }
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignTop
                        spacing: 14

                        Repeater {
                            model: win.secondHalf()
                            delegate: BindRow {}
                        }
                    }
                }

                Rectangle { Layout.fillWidth: true; height: 1; color: win.cOutline; opacity: 0.5 }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 24

                    Repeater {
                        model: win.links
                        delegate: LinkChip {}
                    }

                    Item { Layout.fillWidth: true }
                    Text {
                        text: "Autostart"
                        color: win.cSubtext
                        font.family: win.fontMain
                        font.pixelSize: 12
                    }
                    AutostartSwitch {
                        checked: win.autostartEnabled
                        onToggled: (state) => win.setAutostart(state)
                    }
                }
                
            }
        }

        component BindRow: RowLayout {
            id: row
            required property var modelData
            Layout.fillWidth: true
            spacing: 10

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Row {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 6

                    Repeater {
                        model: row.modelData.combo
                        delegate: Rectangle {
                            width: modelData.length === 1 ? height : keyTxt.implicitWidth + 24
                            height: 34
                            radius: 17
                            color: win.cChip

                            Text {
                                id: keyTxt
                                anchors.centerIn: parent
                                text: modelData
                                color: win.cOnSurface
                                font.family: win.fontMain
                                font.pixelSize: 11
                                font.weight: Font.Medium
                            }
                        }
                    }
                }
            }

            Text {
                Layout.preferredWidth: 200
                text: row.modelData.desc
                color: win.cSubtext
                font.family: win.fontMain
                font.pixelSize: 12
                elide: Text.ElideRight
            }
        }

        component LinkChip: Text {
            required property var modelData
            text: modelData.label
            color: hoverArea.containsMouse ? win.cOnSurface : win.cSubtext
            font.family: win.fontMain
            font.pixelSize: 12
            font.underline: hoverArea.containsMouse

            MouseArea {
                id: hoverArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: Qt.openUrlExternally(parent.modelData.url)
            }
        }
        component AutostartSwitch: Item {
            id: sw
            required property bool checked
            signal toggled(bool state)
            implicitWidth: 40
            implicitHeight: 22

            Rectangle {
                anchors.fill: parent
                radius: height / 2
                color: sw.checked ? win.cOnSurface : win.cOutline
                Behavior on color {
                    ColorAnimation {
                        duration: 180
                        easing.type: Easing.OutCubic
                    }
                }
            }
            Rectangle {
                id: thumb
                width: 16; height: 16; radius: 8
                y: 3
                x: sw.checked ? parent.width - width - 3 : 3
                color: win.cBg
                Behavior on x {
                    NumberAnimation {
                        duration: 220
                        easing.type: Easing.OutBack
                    }
                }
            }
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: sw.toggled(!sw.checked)

            }
        }
        
    }
    Connections {
        target: Quickshell

        function onLastWindowClosed() {
            Qt.quit()
        }
    }
}
