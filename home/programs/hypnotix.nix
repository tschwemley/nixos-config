{pkgs, ...}: {
  # TODO: move this over to programs if it works out well
  home.packages = with pkgs; [hypnotix];
}
