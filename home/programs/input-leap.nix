{pkgs, ...}: {
  home.packages = with pkgs; [
    input-leap
  ];
}
