import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

// TODO: change this to a generic path if I actually create more widgets
const iconPath = `${App.configDir}/topbar/icons`;

export default {
	Text: (text, color = 'black') => Widget.Label({ label: text, css: `color: ${color}`, }),
	IconText: (icon, text, color = 'black') => {
		const w = Widget.Box({
			css: `color: ${color}`,
			children: [
				Widget.Icon({ icon: `${iconPath}/${icon}` }),
				Widget.Label({ label: text })
			],
		});
		console.log(w);
		return w;
	},
}
