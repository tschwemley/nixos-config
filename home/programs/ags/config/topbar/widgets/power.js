import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

const Power = Widget.Button({
	// className: 'volume',
	// css: 'min-width: 180px',
	child: Widget.Icon(`${App.configDir}/topbar/icons/power.svg`),
	on_primary_click: (_, event) => Widget.Menu({
		children: [
			Widget.MenuItem({
				child: Widget.Label('nyx'),
			}),
			Widget.MenuItem({
				child: Widget.Label('sneaks'),
			}),
		],
	}).popup_at_pointer(event),
});

export default Power;
