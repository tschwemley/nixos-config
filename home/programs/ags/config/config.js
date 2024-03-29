import App from 'resource:///com/github/Aylur/ags/app.js';
// import AppLauncher from './launcher/window.js';
import AppLauncher from './launcher/app-launcher.js';
import TopBar from './topbar/index.js';

App.addIcons(`${App.configDir}/assets`);

export default {
	style: `${App.configDir}/style.css`,
	windows: [
		TopBar(),
		AppLauncher,
	],
}
