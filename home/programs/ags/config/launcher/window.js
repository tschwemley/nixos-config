import launcher from './launcher.js';

const WINDOW_NAME = 'applauncher';

// there needs to be only one instance
export const AppLauncher = Widget.Window({
	name: WINDOW_NAME,
	setup: self => self.keybind("Escape", () => {
		App.closeWindow(WINDOW_NAME)
	}),
	visible: false,
	keymode: "exclusive",
	child: launcher({
		windowName: WINDOW_NAME,
		width: 500,
		height: 500,
		spacing: 12,
	}),
})

export default AppLauncher;
