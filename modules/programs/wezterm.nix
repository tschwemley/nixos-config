{ lib, ... }:
let
	config = ./../../home/config/wezterm/wezterm.lua;
in
{
	programs.wezterm.enable = true;
	programs.wezterm.extraConfig  = lib.fileContents config;
}

