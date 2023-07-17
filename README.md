# TODO: 
- Rewrite this

## Features
- uses nix flakes
- standalone home-manager configuration
- separation between user and system state
- desktop/laptop configurations
- self-hosted configurations
- secret management/editing via sops

## Why Nix?
I got too far in before I realized what I got myself into :shrug:
Oh and declarative system configurations across multiple machines or something.

## Architecture
`flake.nix`  - entry point
`home/`		 - standalone home-manager configurations
`hosts/`	 - host specific configurations
`modules/`	 - reusable nixosModules organized by domains.
`templates/` - 
`users/`     - user specific configurations

## Prerequisites
1. Install Nix

## Install Instructions

## About and Acknowlegements
### Inspiration:
- [Graham Chirstensen's Erase Your Darlings](https://grahamc.com/blog/erase-your-darlings/)
- [Mike Royal's NixOS Guide](https://github.com/mikeroyal/NixOS-Guide)
- [misterio77's config](https://github.com/Misterio77/nix-config)

