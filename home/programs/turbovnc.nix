{pkgs, ...}: {
  home.packages = with pkgs; [
    turbovnc
  ];
}
