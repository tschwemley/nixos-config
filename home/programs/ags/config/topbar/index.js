import Clock from './widgets/clock.js';
import ClientTitle from './widgets/clienttitle.js';
import Media from './widgets/media.js';
import Power from './widgets/power.js';
import SysTray from './widgets/systray.js';
import Volume from './widgets/volume.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Workspaces from './widgets/workspaces.js';

const Left = Widget.Box({
	children: [
		Workspaces(),
		ClientTitle(),
	],
	spacing: 8,
});

const Center = Widget.Box({
	children: [Media(),],
	spacing: 8,
});

const Right = Widget.Box({
	hpack: 'end',
	spacing: 8,
	children: [
		Volume(),
		Clock(),
		SysTray(),
		Power,
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
