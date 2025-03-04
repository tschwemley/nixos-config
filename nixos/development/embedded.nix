{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    platformio
    platformio-core
  ];
}
