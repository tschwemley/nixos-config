{pkgs, ...}: let
  userName = "tschwemley";
in {
  imports = [
    ./.
  ];

  home = {
    inherit userName;
    homeDirectory =
      if builtins.currentSystem == "x86_64-linux"
      then "/home/${userName}"
      else "/Users/${userName}";
  };
}
