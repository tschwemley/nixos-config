{ pkgs, ... }: {
  home.packages = with pkgs; [
    gajim
  ];
}
