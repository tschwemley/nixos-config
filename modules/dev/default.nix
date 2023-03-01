{ inputs, ... }:
let
	pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
in
{
	flake.nixosModules.dev ={
		all = {
			inherit node rust;
		};

		node = {
			environment.systemPackages = with pkgs; [
				bun
				nodejs
				nodePackages.typescript
			];
		};
		
		rust = {
			environment.systemPackages = with pkgs; [
				cargo
				rustc
				rustfmt
			];
		};
	};
}
