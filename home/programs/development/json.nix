{pkgs, ...}: {
  home.packages = [pkgs.fx];

  programs = {
    jq.enable = true;

    jqp = {
      enable = true;
      settings.theme.name = "gruvbox";
    };
  };
}
