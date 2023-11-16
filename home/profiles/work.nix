let
  username = "tschwemley";
in {
  imports = [
    ./.
  ];

  home = {
    inherit username;
    homeDirectory =
      if builtins.currentSystem == "x86_64-linux"
      then "/home/${username}"
      else "/Users/${username}";
  };
}
