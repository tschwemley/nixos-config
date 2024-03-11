import Colors from '../colors.js';
import Helpers from '../helpers.js';
import Variable from 'resource:///com/github/Aylur/ags/variable.js';

const variables = {
	memory: Variable(0, {
		poll: [2000, 'free', out => Helpers.percent(out.split('\n')
			.find(line => line.includes('Mem:'))
			.split(/\s+/)
			.splice(1, 2))
		],
	}),
};

const { memory } = variables;

const memoryWidget = Helpers.IconText('memory', memory.bind().as(v => `${v}%`), Colors.orange);

export default memoryWidget;
