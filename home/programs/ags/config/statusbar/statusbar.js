import * as widgets from './widgets.js';

// layout of the bar
function left() {
  return Widget.Box({
    spacing: 8,
    children: [
      widgets.Workspaces(),
    ],
  })
}

function center() {
  return Widget.Box({
    spacing: 8,
    children: [
      widgets.ClientTitle(),
      widgets.Media(),
      widgets.Notification(),
    ],
  })
}

function right() {
  return Widget.Box({
    hpack: "end",
    spacing: 8,
    children: [
      widgets.Volume(),
      widgets.Clock(),
      widgets.SysTray(),
    ],
  })
}

export default function Bar(monitor = 0) {
  return Widget.Window({
    name: `bar-${monitor}`, // name has to be unique
    class_name: "bar",
    monitor,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      start_widget: left(),
      center_widget: center(),
      end_widget: right(),
    }),
  })
}
