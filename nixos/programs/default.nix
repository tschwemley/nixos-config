{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    age
    git
    gnupg
    jq
    pinentry
    pwgen
    ripgrep
    rsync
    sops
    systemctl-tui
  ];
}
