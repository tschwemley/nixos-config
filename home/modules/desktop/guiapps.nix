{ pkgs, ... }: {
  imports = [
    ./steam.nix
  ];

  environment.systemPackages = with pkgs; [
    brave
    firefox

    vlc

	# X stuff
	# TODO: if I decide to keep them move this somewhere else
    # caffeine-ng
    # xorg.xdpyinfo
    xorg.xrandr
    xclip
    xsel
    # arandr
  ];
}
