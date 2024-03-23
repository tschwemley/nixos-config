import { WINDOW_NAME } from './window.js';

const spacing = 12;

const searchBox = applications => Widget.Entry({
	hexpand: true,
	css: `margin-bottom: ${spacing}px;`,

	// to launch the first item on Enter
	on_accept: () => {
		// make sure we only consider visible (searched for) applications
		const results = applications.filter((item) => item.visible);
		if (results[0]) {
			App.toggleWindow(WINDOW_NAME)
			applications[0].attribute.app.launch()
		}
	},

	// filter out the list
	on_change: ({ text }) => applications.forEach(item => {
		item.visible = item.attribute.app.match(text ?? "")
	}),
})

export default searchBox;
