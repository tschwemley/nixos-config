{ pkgs, ... }:
{
  imports = [ ./nerdfetch.nix ];

  # TODO: slowly move these pkgs into appropriate subcategories
  environment.systemPackages = with pkgs; [
    age
    git
    gnupg
    isd
    jdupes
    nrepl
    pinentry
    ripgrep
    rsync
    sops
  ];
}
