{ inputs, pkgs, ... }:
{
  imports = [
    ./brave.nix
    ./librewolf.nix
    ./mullvad-browser.nix
    ./ungoogled-chromium.nix
  ];

  home.packages = with pkgs; [
    inputs.zen-browser.packages."${pkgs.system}".default

    lynx
    tor-browser
  ];
}
