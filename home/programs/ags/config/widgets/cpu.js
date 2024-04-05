import Colors from '../colors.js';
import Helpers from '../helpers.js';
import Variable from 'resource:///com/github/Aylur/ags/variable.js';

const variables = {
	cpu: Variable(0, {
		poll: [2000, 'top -b -n 1', out => out.split('\n')
			.find(line => line.includes('Cpu(s)'))
			.split(/\s+/)[1]
			.replace(',', '.')],
	}),
};

const { cpu } = variables;

// const cpuWidget = Helpers.IconText('cpu', cpu.bind().as(v => `${v}%`), Colors.green);
const cpuWidget = Widget.Box({
	children: [
		Widget.Label({ css: `color: ${Colors.green}; font-weight: bold; margin-right: 5px;`, label: 'C:' }),
		Widget.Label({ label: cpu.bind().as(v => `${v}%`) }),
	],
	css: 'margin-right: 15px',
})

export default cpuWidget;
