import Clock from './widgets/clock.js';
import SysTray from './widgets/systray.js';
import Volume from './widgets/volume.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

const Left = Widget.Box({
	children: [],
});

const Center = Widget.Box({
	children: [],
});

const Right = Widget.Box({
	children: [
		Volume(),
		Clock(),
		SysTray(),
	],
});

const TopBar = ({ monitor } = {}) => Widget.Window({
	name: `bar-${monitor}`, // name has to be unique
	className: 'bar',
	monitor,
	anchor: ['top', 'left', 'right'],
	exclusivity: 'exclusive',
	child: Widget.CenterBox({
		startWidget: Left,
		centerWidget: Center,
		endWidget: Right,
	}),
});

export default TopBar;
