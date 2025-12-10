{ pkgs, ... }:
{
  imports = [ ./nerdfetch.nix ];

  # TODO: slowly move these pkgs into appropriate subcategories
  environment.systemPackages = with pkgs; [
    age
    file
    git
    gnupg
    hwinfo
    hw-probe
    isd
    jdupes
    nrepl
    pinentry-curses
    ripgrep
    rsync
    sops
  ];
}
