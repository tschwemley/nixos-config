import Widget from 'resource:///com/github/Aylur/ags/widget.js';

// TODO: change this to a generic path if I actually create more widgets

const helpers = {
	divide: ([a, b]) => b / a,
	percent: ([a, b]) => (helpers.divide([a, b]) * 100).toFixed(2),

	Text: (text, color = 'black') => Widget.Label({ label: text, css: `color: ${color}`, }),

	IconText: (icon, text, color = 'black') => {
		const w = Widget.Box({
			css: `color: ${color}`,
			children: [
				Widget.Icon({ icon: icon }),
				Widget.Label({ label: text })
			],
		});
		console.log(w);
		return w;
	},
}

export default helpers;
