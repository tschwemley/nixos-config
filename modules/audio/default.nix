{ self, ... }:
{
	flake = {
		audio = rec {
			all = {
				imports = [
					jack
					bluetooth
					pulseaudio
				];
			};

			bluetooth = {
				hardware.bluetooth.enable = true;
				services.blueman.enable = true;
			};

			jack = {
			  services.jack = {
				jackd.enable = true;
				# support ALSA only programs via ALSA JACK PCM plugin
				alsa.enable = false;
				# support ALSA only programs via loopback device (supports programs like Steam)
				loopback = {
				  enable = true;
				  # buffering parameters for dmix device to work with ALSA only semi-professional sound programs
				  #dmixConfig = ''
				  #  period_size 2048
				  #'';
				};
			  };

			  # TODO: make this dynamic
			  users.users.schwem.extraGroups = [ "jackaudio" ];
			};

			pulseaudio = {
				hardware.pulseaudio.enable = true;
			};
		};
	};
}
#---
# Relavent links
# - https://nixos.wiki/wiki/Bluetooth
# - https://nixos.wiki/wiki/JACK
# - https://nixos.wiki/wiki/PulseAudio
#---
