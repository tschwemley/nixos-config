import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';


const powerIcon = () => Widget.Icon(`${App.configDir}/topbar/icons/power.svg`);
const restartIcon = () => Widget.Icon(`${App.configDir}/topbar/icons/restart.svg`);

const Power = Widget.Button({
	// className: 'volume',
	child: powerIcon(),
	on_primary_click: (_, event) => Widget.Menu({
		css: 'margin: auto',
		children: [
			Widget.MenuItem({ child: powerIcon() }),
			Widget.MenuItem({ child: restartIcon() }),
		],
	}).popup_at_pointer(event),
});

export default Power;
