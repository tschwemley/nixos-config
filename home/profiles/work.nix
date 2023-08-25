{system, ...}: let
  username = "tschwemley";
in {
  imports = [
    ./.
    ../programs/wezterm
  ];

  home = {
    inherit username;
    homeDirectory =
      if system == "x86_64-linux"
      then "/home/${username}"
      else "/Users/${username}";
  };
}
