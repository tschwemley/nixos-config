import appItem from './item.js';

const height = 500;
const width = 500;
const spacing = 12;

const list = applications => Widget.Box({
	vertical: true,
	children: applications,
	spacing,
});

const appList = applications => Widget.Scrollable({
	hscroll: "never",
	css: `min-width: ${width}px;`
		+ `min-height: ${height}px;`,
	child: list(applications),
});


export default appList;
