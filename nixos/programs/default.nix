{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    age
    curl
    git
    gnupg
    ogen
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
