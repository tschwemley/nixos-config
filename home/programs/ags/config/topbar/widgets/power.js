import Widget from 'resource:///com/github/Aylur/ags/widget.js';

const Power = Widget.Button({
	// className: 'volume',
	// css: 'min-width: 180px',
	child: Widget.Label('power'),
	on_primary_click: () => print('echo hello')
});

export default Power;
