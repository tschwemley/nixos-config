{pkgs, ...}: {
  imports = [./.];
  home = {
    homeDirectory = "/home/tschwemley";
    packages = with pkgs; [
      coreutils
      openssh
    ];
    username = "tschwemley";
  };
}
