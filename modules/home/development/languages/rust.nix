{ pkgs, ... }: {
	environment.systemPackages = with pkgs; [
		cargo
		rust
		rustup # TODO: decide if this is actually needed
		rustc
		rustfmt
	];
}
