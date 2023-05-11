- uses nix flakes
- home-manager
- desktop/laptop configurations
- server (self-hosted) configurations
- split between system and user configurataion
- secret management

## Repo Features

## Why Nix?
I got too far in before I realized what I got myself into :shrug:
Oh and declarative system configurations across multiple machines or something.

## Architecture
`flake.nix` - entry point
`home/`		- home configurations via home-manager
`hosts/`	- nixos configurations
`overlays/` - overlays/overrides for particularly packages
`pkgs/`
`templates/`

## Prerequisites
1. Install Nix

## Install Instructions

## About and Acknowlegements
### Inspiration:
- [Graham Chirstensen's Erase Your Darlings](https://grahamc.com/blog/erase-your-darlings/)
- [Mike Royal's NixOS Guide](https://github.com/mikeroyal/NixOS-Guide)
- [misterio77's config](https://github.com/Misterio77/nix-config)
- [srid's NixOS Config](https://github.com/Misterio77/nix-config)

