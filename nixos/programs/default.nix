{ pkgs, ... }:
{
  imports = [ ./nerdfetch.nix ];

  # TODO: slowly move these pkgs into appropriate subcategories
  environment.systemPackages = with pkgs; [
    age
    fd
    file
    git
    gnupg
    hwinfo
    hw-probe
    isd
    jdupes
    ripgrep
    rsync
    sops
  ];
}
