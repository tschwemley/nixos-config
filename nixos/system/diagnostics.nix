{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    memtester
    memtest86plus
    smartmontools
    stress-ng
  ];
}
