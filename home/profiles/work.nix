{
  pkgs,
  system,
  ...
}: let
  git = import ../programs/git.nix {
    name = "Tyler Schwemley";
    email = "tschwemley@zynga.com";
  };
in {
  imports = [
    git
    ./.
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
    sessionVariables = {
      TERM = "xterm-256colors";
    };
  };
}
