import appItem from './item.js';
import appList from './list.js';
import searchBox from './search-box.js';

import { WINDOW_NAME } from './window.js';

const { query } = await Service.import("applications")

const launcher = ({ width = 500, height = 500, spacing = 12 }) => {
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
			if (windowName !== WINDOW_NAME)
				return

			// when the applauncher shows up
			if (visible) {
				appList.child.children = query("").map(appItem);
				search.text = "";
				search.grab_focus();
			}
		}),
	})
}

export default launcher;
