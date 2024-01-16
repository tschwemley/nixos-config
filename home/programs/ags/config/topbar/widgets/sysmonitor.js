import App from 'resource:///com/github/Aylur/ags/app.js';
import Variable from 'resource:///com/github/Aylur/ags/variable.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

const iconPath = `${App.configDir}/topbar/icons`;
const divide = ([total, free]) => free / total;

const variables = {
	cpu: Variable(0, {
		poll: [2000, 'top -b -n 1', out => divide([100, out.split('\n')
			.find(line => line.includes('Cpu(s)'))
			.split(/\s+/)[1]
			.replace(',', '.')])],
	}),

	ram: Variable(0, {
		poll: [2000, 'free', out => divide(out.split('\n')
			.find(line => line.includes('Mem:'))
			.split(/\s+/)
			.splice(1, 2))],
	}),

	disk: Variable(0, {
		// poll: [60000, 'df /', out => divide([100, out])]
		poll: [1000, 'df /', out => divide([100, out.split('\n')
			.find(line => line.includes('% /'))
			.split(/\s+/)
			.splice(4, 1)
			.pop()
			.slice(0, -1)])],
	}),

};

const { cpu, disk, ram, } = variables;
const cpuProgress = Widget.CircularProgress({
	child: Widget.Icon({
		icon: `${iconPath}/cpu.svg`,
	}),
	value: cpu.bind(),
});

const ramProgress = Widget.CircularProgress({
	child: Widget.Icon({
		icon: `${iconPath}/ram1.svg`,
	}),
	value: ram.bind()
});

const diskProgress = Widget.CircularProgress({
	child: Widget.Icon({
		icon: `${iconPath}/ram1.svg`,
	}),
	value: disk.bind()
});

const SysMonitor = () => Widget.Box({
	css: 'color: black;',
	children: [
		cpuProgress,
		ramProgress,
		diskProgress,
	],
});

export default SysMonitor;
