{ self, ... }:
let
	bat = import ./programs/bat.nix;
	ba = import ./programs/bat.nix;
	bat = import ./programs/bat.nix;
	bat = import ./programs/bat.nix;
	bat = import ./programs/bat.nix;
in
{
	flake.modules.programs = rec {
		all = {
			imports = [
				bat
			];
		};
	};
	# imports = [
	# 	./audio
	# 	./dev
	# 	./fonts
	# 	./programs
	# ];
}
