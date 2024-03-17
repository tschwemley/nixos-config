const hyprland = await Service.import('hyprland');

const dispatch = workspace => hyprland.messageAsync(`dispatch workspace ${workspace}`);

const Workspaces = () => Widget.EventBox({
	// TODO: listener definitions
	child: Widget.Box({
		children: Array.from({ length: 4 }, (_, i) => i++).map(i => Widget.Button({
			attribute: i,
			label: `${i}`,
			onClicked: () => dispatch(i),
			css: `background: none; border-radius: 0; border: none;`,
		})),

		// TODO: decide if I want to keep. W/o it displays all workspaces set in workspace rules
		setup: self => self.hook(hyprland, () => self.children.forEach(btn => {
			btn.visible = hyprland.workspaces.some(ws => ws.id === btn.attribute);
		})),
	}),
});

export default Workspaces;
