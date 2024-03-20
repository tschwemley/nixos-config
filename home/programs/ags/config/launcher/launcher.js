import appList from './list.js';
import appItem from './item.js';
import searchBox from './search-box.js';

const { query } = await Service.import("applications")

const launcher = ({ windowName, width = 500, height = 500, spacing = 12 }) => {
	// list of application buttons
	let applications = query("").map(appItem)

	// container holding the buttons
	const list = appList(applications);
	const search = searchBox(applications);

	return Widget.Box({
		vertical: true,
		css: `margin: ${spacing * 2}px;`,
		children: [
			search,
			list
		],
		setup: self => self.hook(App, (_, windowName, visible) => {
			if (windowName !== windowName)
				return

			// when the applauncher shows up
			if (visible) {
				list.repopulate();
				search.text = "";
				search.grab_focus();
			}
		}),
	})
}

export default launcher;
