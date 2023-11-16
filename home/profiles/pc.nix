{username ? "schwem", ...}: {
  imports = [
    ../programs/lazygit.nix
    ../programs/reaper.nix
	../terminals/wezterm.nix
	../window-managers
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
}
