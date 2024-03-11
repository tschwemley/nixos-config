import cpu from '../../widgets/cpu.js';
import memory from '../../widgets/memory.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

const SysMonitor = () => Widget.Box({
	css: 'color: black;',
	children: [
		cpu,
		memory,
	],
});

export default SysMonitor;
