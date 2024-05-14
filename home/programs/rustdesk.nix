{pkgs, ...}: {
  # TODO: remove synergy or create "remote" module/dir
  home.packages = with pkgs; [rustdesk synergy];
}
