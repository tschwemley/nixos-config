import App from 'resource:///com/github/Aylur/ags/app.js';
import Variable from 'resource:///com/github/Aylur/ags/variable.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

const iconPath = `${App.configDir}/topbar/icons`;
const divide = ([total, free]) => free / total;

const cpu = Variable(0, {
	poll: [2000, 'top -b -n 1', out => divide([100, out.split('\n')
		.find(line => line.includes('Cpu(s)'))
		.split(/\s+/)[1]
		.replace(',', '.')])],
});

const ram = Variable(0, {
	poll: [2000, 'free', out => divide(out.split('\n')
		.find(line => line.includes('Mem:'))
		.split(/\s+/)
		.splice(1, 2))],
});

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

const SysMonitor = () => Widget.Box({
	css: 'color: black;',
	children: [
		cpuProgress,
		ramProgress,
	],
});

export default SysMonitor;
