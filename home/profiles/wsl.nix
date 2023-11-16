{pkgs, ...}: {
  imports = [./pc.nix];
  home = {
    homeDirectory = "/home/tschwemley";
    packages = with pkgs; [coreutils];
    username = "tschwemley";
  };
}
