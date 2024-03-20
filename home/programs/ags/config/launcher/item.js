/** @param {import('resource:///com/github/Aylur/ags/service/applications.js').Application} app */
const appItem = app => Widget.Button({
	on_clicked: () => {
		App.closeWindow(WINDOW_NAME)
		app.launch()
	},
	attribute: { app },
	child: Widget.Box({
		children: [
			Widget.Icon({
				icon: app.icon_name || "",
				size: 42,
			}),
			Widget.Label({
				class_name: "title",
				label: app.name,
				xalign: 0,
				vpack: "center",
				truncate: "end",
			}),
		],
	}),
})

export default appItem;
