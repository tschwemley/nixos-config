{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    insomnia
    tealdeer
  ];
}
