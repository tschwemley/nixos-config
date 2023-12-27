import Mpris from 'resource:///com/github/Aylur/ags/service/mpris.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

const Media = () => Widget.Button({
	class_name: 'media',
	on_primary_click: () => Mpris.getPlayer('')?.playPause(),
	on_scroll_up: () => Mpris.getPlayer('')?.next(),
	on_scroll_down: () => Mpris.getPlayer('')?.previous(),
	child: Widget.Label('-').hook(Mpris, self => {
		const players = [];
		for (let player of Mpris.players) {
			if (player.play_back_status != 'Stopped') {
				players.push(player);
			}
		}

		if (players.length > 0) {
			// TODO: make this smarter instead of choosing from first found player
			const { track_artists, track_title } = players[0];
			self.label = `${track_artists.join(', ')} - ${track_title}`;
		} else {
			self.label = 'Nothing is playing';
		}
	}, 'player-changed'),
});

export default Media;
