import SystemTray from 'resource:///com/github/Aylur/ags/service/systemtray.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

const SysTray = () => Widget.Box({
	children: SystemTray.bind('items').as(items => {
		items.map(item => Widget.Button({
			child: Widget.Icon().bind('icon', item, 'icon'),
			tooltipMarkup: item.bind('tooltip_markup'),
			onPrimaryClick: (_, event) => {
				console.log(event);
				item.activate(event)
			},
			onSecondaryClick: (_, event) => {
				console.log(event);
				item.openMenu(event)
			},
		}));
	}),
});

export default SysTray;
