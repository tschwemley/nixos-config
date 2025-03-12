{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    age
    git
    gnupg
    jq
    nrepl
    pinentry
    pwgen
    ripgrep
    rsync
    sops
    systemctl-tui
  ];
}
