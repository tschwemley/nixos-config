{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    age
    comma
    curl
    git
    gnupg
    jdupes
    jq
    lsof
    pinentry
    pwgen
    ripgrep
    rsync
    sops
    systemctl-tui
    tree
    unzip
    wget
    zip
  ];
}
