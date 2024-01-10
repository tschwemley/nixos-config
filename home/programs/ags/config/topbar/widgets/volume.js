import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';
import Variable from 'resource:///com/github/Aylur/ags/variable.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

const lastVolume = Variable(1);

const volumeIndicator = Widget.Stack({
	css: "color: black;",
	items: [
		// tuples of [string, Widget]
		['101', Widget.Icon('audio-volume-overamplified-symbolic')],
		['67', Widget.Icon('audio-volume-high-symbolic')],
		['34', Widget.Icon('audio-volume-medium-symbolic')],
		['1', Widget.Icon('audio-volume-low-symbolic')],
		['0', Widget.Icon('audio-volume-muted-symbolic')],
	],
	connections: [[Audio, self => {
		if (!Audio.speaker)
			return;

		if (Audio.speaker.isMuted) {
			self.shown = '0';
			return;
		}

		const show = [101, 67, 34, 1, 0].find(
			threshold => threshold <= Audio.speaker.volume * 100);

		self.shown = `${show}`;
	}, 'speaker-changed']],
});

const Volume = () => Widget.Box({
	className: 'volume',
	css: 'min-width: 180px',
	children: [
		Widget.EventBox({
			child: volumeIndicator,
			on_primary_click: () => {
				const curVolume = Audio.speaker.volume;
				const newVolume = Audio.speaker.isMuted ? lastVolume.value : 0;

				lastVolume.value = curVolume;
				Audio.speaker.volume = newVolume;
			},
			on_secondary_click: () => /* TODO: audio options */ null,
		}),
		Widget.Slider({
			hexpand: true,
			drawValue: false,
			onChange: ({ value }) => Audio.speaker.volume = value,
			connections: [[Audio, self => {
				self.value = Audio.speaker?.volume || 0;
			}, 'speaker-changed']],
		}),
	],
});

export default Volume;
