{
  pkgs,
  system,
  ...
}: {
  imports = [
    ./.
    ../programs/wezterm
  ];

  home = let
    username = "tschwemley";
  in {
    inherit username;
    homeDirectory =
      if system == "x86_64-linux"
      then "/home/${username}"
      else "/Users/${username}";

    # work specific programs to install
    packages = with pkgs; [
      mysql
    ];
  };
}
