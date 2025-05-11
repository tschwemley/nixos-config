# TODO: slowly move these files into appropriate subcategories
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    age
    git
    gnupg
    nrepl
    pinentry
    ripgrep
    rsync
    sops
    systemctl-tui
  ];
}
