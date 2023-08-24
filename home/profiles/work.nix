{system, ...}: let
  username = "tschwemley";
in {
  imports = [
    ./.
  ];

  home = {
    inherit username;
    homeDirectory =
      if system == "x86_64-linux"
      then "/home/${username}"
      else "/Users/${username}";
  };
}
