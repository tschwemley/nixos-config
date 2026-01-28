{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./.

    ../programs/glow.nix
    ../programs/jira-cli.nix
    ../programs/wcalc.nix
    ../xdg/ssh/work.nix
  ];

  home =
    let
      username = "tschwemley";
    in
    {
      inherit username;
      homeDirectory = "/home/${username}";
    };

  # not 100% sure why this is necessary but without it there's this error:
  # A corresponding Nix package must be specified via `nix.package` for generating nix.conf. 🤷
  nix.package = pkgs.nix;

  programs.git.userEmail = lib.mkDefault "tschwemley@zynga.com";
  targets.genericLinux.enable = true;
}
