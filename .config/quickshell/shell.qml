import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

ShellRoot {
  // ===== your palette =====
  readonly property color col_primary:        "#202020"
  readonly property color col_secondary:      "#f5f5f5"

  readonly property color col_black:          "#080808"
  readonly property color col_red:            "#cf4f43"
  readonly property color col_green:          "#54964f"
  readonly property color col_yellow:         "#d17536"
  readonly property color col_blue:           "#1b4666"
  readonly property color col_magenta:        "#5e196d"
  readonly property color col_cyan:           "#5e8b8d"
  readonly property color col_white:          "#cecece"

  readonly property color col_bright_black:   "#323232"
  readonly property color col_bright_red:     "#993e36"
  readonly property color col_bright_green:   "#5c8b59"
  readonly property color col_bright_yellow:  "#aa9c30"
  readonly property color col_bright_blue:    "#1267a5"
  readonly property color col_bright_magenta: "#8910ad"
  readonly property color col_bright_cyan:    "#61c4c6"
  readonly property color col_bright_white:   "#e0e0e0"

  // theme knobs
  readonly property color bar_bg: col_primary
  readonly property color text_dim: col_white
  readonly property color text: col_secondary
  // dominant accent: prefer bright white; switch to col_white if you want it subtler
  readonly property color accent: col_white

  readonly property int pad: 4
  readonly property int barH: 36
  readonly property int radius: 8

  PanelWindow {
    anchors { top: true; left: true; right: true }
    implicitHeight: barH
    color: "transparent"

    // background
    Rectangle {
      anchors.fill: parent
      radius: radius
      opacity: 0.94
      color: bar_bg
    }

    // content row: left-aligned workspace chips
    RowLayout {
      anchors.fill: parent
      anchors.margins: pad
      spacing: 6

      Repeater {
        model: Hyprland.workspaces
        delegate: Rectangle {
          required property HyprlandWorkspace modelData

          // --- skip special workspaces ---
          // treat as special if:
          //  - explicit .special flag (when present)
          //  - negative id (Hyprland's special WS)
          //  - name starts with "special"
          readonly property bool isSpecial:
            (modelData.special === true) ||
            (modelData.id < 0) ||
            (modelData.name && modelData.name.toLowerCase().startsWith("special"))

          visible: !isSpecial   // RowLayout ignores invisible children

          implicitHeight: parent ? parent.height - 2*2 : 28
          implicitWidth: 28
          radius: 6

          // focused = filled accent; otherwise subtle outline
          color: modelData.focused ? accent : "transparent"
          border.color: modelData.focused ? accent : col_bright_black
          border.width: 1

          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: modelData.activate()
          }

          Text {
            anchors.centerIn: parent
            text: modelData.name !== "" ? modelData.name : modelData.id
            font.pixelSize: 12
            font.bold: modelData.focused
            color: modelData.focused ? col_black : text
            elide: Text.ElideRight
          }
        }
      }

      // keep the rest empty for now (we'll add features step-by-step)
      Item { Layout.fillWidth: true }
    }
  }
}

