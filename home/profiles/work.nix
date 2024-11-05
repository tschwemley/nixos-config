{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./.
    ../programs/glow.nix
    ../programs/jira-cli.nix
    ../programs/wcalc.nix
    ../xdg/ssh/work.nix
  ];

  home = {
    homeDirectory = "/Users/tschwemley";
    username = "tschwemley";

    packages = with pkgs; [
      mariadb
      nodejs
    ];
  };

  programs = {
    git = {
      userEmail = lib.mkDefault "tschwemley@zynga.com";
    };

    zsh.shellAliases = {
      # see: https://so.schwem.io/questions/13713101/rsync-exclude-according-to-gitignore-hgignore-svnignore-like-filter-c
      rsync = "rsync -vhra --include='**.gitignore' --exclude='/.git' --filter=':- .gitignore' --delete-after";
    };
  };

  sops.age.keyFile = "/etc/sops/age-keys.txt";
}
