const helpers = {
	divide: ([a, b]) => b / a,
	percent: ([a, b]) => (helpers.divide([a, b]) * 100).toFixed(2),

	Text: (text, color = 'black') => Widget.Label({ label: text, css: `color: ${color}`, }),

	IconText: (icon, text, color = '#fff', size = 28) => {
		const w = Widget.Box({
			children: [
				Widget.Icon({ icon: icon, css: `color: ${color}`, size }),
				Widget.Label({ label: text })
			],
		});
		return w;
	},
}

export default helpers;

// TODO: change this file to a generic path if I actually create more widgets
