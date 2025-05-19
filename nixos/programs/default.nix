{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # TODO: slowly move these pkgs into appropriate subcategories
    age
    git
    gnupg
    jdupes
    nrepl
    pinentry
    ripgrep
    rsync
    sops
    systemctl-tui
  ];
}
