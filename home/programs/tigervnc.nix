{pkgs, ...}: {
  home.packages = with pkgs; [
    tigervnc
  ];
}
