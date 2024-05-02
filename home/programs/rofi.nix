{pkgs, ...}: {
  home.packages = with pkgs; [rofimoji];
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    # package = pkgs.rofi-wayland.override {
    #   plugins = with pkgs; [
    #     rofi-calc
    #   ];
    # };
    plugins = with pkgs; [
      rofi-calc
    ];
    terminal = "${pkgs.kitty}/bin/kitty";
    theme = "gruvbox-dark";
  };
}
