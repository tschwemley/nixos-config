import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import SystemTray from 'resource:///com/github/Aylur/ags/service/systemtray.js';

// const SysTrayItem = item => Widget.Button({
// 	child: Widget.Icon().bind('icon', item, 'icon'),
// 	tooltipMarkup: item.bind('tooltip-markup'),
// 	onPrimaryClick: (_, event) => item.activate(event),
// 	onSecondaryClick: (_, event) => item.openMenu(event),
// });
//
// const SysTray = () => Widget.Box()
// 	.bind('children', SystemTray, 'items', i => i.map(SysTrayItem))

const SysTray = () => Widget.Box({
	children: SystemTray.bind('items').transform(items => {
		return items.map(item => Widget.Button({
			child: Widget.Icon({ binds: [['icon', item, 'icon']] }),
			on_primary_click: (_, event) => item.activate(event),
			on_secondary_click: (_, event) => item.openMenu(event),
			binds: [['tooltip-markup', item, 'tooltip-markup']],
		}));
	}),
});

export default SysTray;
