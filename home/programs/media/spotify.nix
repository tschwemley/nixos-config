{pkgs, ...}: {
  home.packages = with pkgs; [
    spicetify-cli
    spotify
  ];
}
