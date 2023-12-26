import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

const ClientTitle = () => Widget.Label({
	class_name: 'client-title',
	label: Hyprland.active.client.bind('title'),
});

export default ClientTitle;
