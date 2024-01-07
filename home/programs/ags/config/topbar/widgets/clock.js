import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import { execAsync } from 'resource:///com/github/Aylur/ags/utils.js';

const Clock = () => Widget.Label({
	className: 'clock',
	css: 'color: black',
	connections: [
		// this is bad practice, since exec() will block the main event loop
		// in the case of a simple date its not really a problem
		// [1000, self => self.label = exec('date "+%H:%M:%S %b %e."')],

		// this is what you should do
		[1000, self => execAsync(['date', '+%H:%M:%S %b %e.'])
			.then(date => self.label = date).catch(console.error)],
	],
});

export default Clock;
