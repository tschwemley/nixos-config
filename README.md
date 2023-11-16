## About
Custom written nix flake configuration with standalone home-manager configs. A pinch of inspiration
from other config repos thrown in to add texture.

## Features
- desktop/laptop configurations
- k3s configuration
- standalone home-manager configuration
- secret management via sops
- uses nix flakes
- wireguard site-to-site config

## Why Nix?
Why not?

## Architecture
Mirrors the flake.nix format with minor changes for mneomnic reasons. Home-manager config is in
home directory. Xdg config files live in-place with the module(s) that use them.

## Prerequisites
- Install nix package manager
- (optional) Install [Home Manager](https://github.com/nix-community/home-manager) for standalone
    home usage

## Install Instructions
TODO

## Acknowlegements
### References
- [Graham Chirstensen's Erase Your Darlings](https://grahamc.com/blog/erase-your-darlings/)
- [Mic92's dotfiles](https://github.com/mic92/dotfiles)
- [misterio77's config](https://github.com/Misterio77/nix-config)


