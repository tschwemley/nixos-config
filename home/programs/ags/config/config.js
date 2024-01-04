import App from 'resource:///com/github/Aylur/ags/app.js';
import TopBar from './topbar/index.js';

export default {
	style: `${App.configDir}/style.css`,
	windows: [
		TopBar(),
	],
}
