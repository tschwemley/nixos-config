import Widget from 'resource:///com/github/Aylur/ags/widget.js';

const Left = Widget.Box({
	children: [],
});

const Center = Widget.Box({
	children: [],
});

const Clock = () => Widget.Label({
	className: 'clock',
	connections: [
		// this is bad practice, since exec() will block the main event loop
		// in the case of a simple date its not really a problem
		[1000, self => self.label = exec('date "+%H:%M:%S %b %e."')],

		// this is what you should do
		[1000, self => execAsync(['date', '+%H:%M:%S %b %e.'])
			.then(date => self.label = date).catch(console.error)],
	],
});

const Right = Widget.Box({
	children: [
		Clock(),
	],
});

const TopBar = ({ monitor } = {}) => Widget.Window({
	name: `bar-${monitor}`, // name has to be unique
	className: 'bar',
	monitor,
	anchor: ['top', 'left', 'right'],
	exclusivity: 'exclusive',
	child: Widget.CenterBox({
		startWidget: Left(),
		centerWidget: Center(),
		endWidget: Right(),
	}),
});

export default TopBar;
