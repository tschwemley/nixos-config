const cpu = Variable(0, {
  poll: [2000, 'top -b -n 1', out => divide([100, out.split('\n')
    .find(line => line.includes('Cpu(s)'))
    .split(/\s+/)[1]
    .replace(',', '.')]).value],
})

export default function SysMonitor() {
  //const items = systemtray.bind("items")
  //  .as(items => items.map(item => Widget.Button({
  //    child: Widget.Icon({ icon: item.bind("icon") }),
  //    on_primary_click: (_, event) => item.activate(event),
  //    on_secondary_click: (_, event) => item.openMenu(event),
  //    tooltip_markup: item.bind("tooltip_markup"),
  //  })))

  return Widget.Label({
    class_name: "sysmonitor",
    label: `CPU: ${cpu.bind()}%`,
  })
}
