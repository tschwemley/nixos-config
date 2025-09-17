{ pkgs, ... }:
{
  imports = [ ./nerdfetch.nix ];

  # TODO: slowly move these pkgs into appropriate subcategories
  environment.systemPackages = with pkgs; [
    age
    git
    gnupg
    hw-probe
    isd
    jdupes
    nrepl
    pinentry
    ripgrep
    rsync
    sops
  ];
}
