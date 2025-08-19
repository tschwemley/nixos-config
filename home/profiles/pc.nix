{
  self,
  config,
  ...
}:
{
  imports = [
    ./.
    ../programs/ai
    ../programs/browsers
    ../programs/communication
    ../programs/creative
    ../programs/development/bruno.nix
    ../programs/development/databases.nix
    ../programs/development/nix.nix
    ../programs/gnome
    ../programs/media
    ../programs/music
    ../programs/productivity

    ../programs/bitwarden.nix
    ../programs/cowsay.nix
    ../programs/glow.nix
    ../programs/nemo.nix
    ../programs/qt.nix
    ../programs/reddit-tui.nix
    ../programs/taskwarrior.nix
    ../programs/wayland/hyprland
    ../programs/wcalc.nix
    ../programs/wofi.nix
    ../programs/zathura.nix

    ../services/kdeconnect.nix
    ../services/mpris-proxy.nix

    ../theme

    ../xdg
    ../xdg/netrc.nix
    ../xdg/ssh/personal.nix
  ];

  home = {
    homeDirectory = "/home/schwem";
    username = "schwem";

    sessionVariables = {
      VISUAL = "nvim";
    };
  };

  # pc specific program config
  programs = {
    git.extraConfig.url = {
      "ssh://gh" = {
        insteadOf = "https://github.com";
      };
    };

    zsh.envExtra = "source ${config.sops.secrets.private-env-vars.path}";
  };

  sops.secrets.private-env-vars = {
    key = "";
    format = "dotenv";
    mode = "0400";
    sopsFile = self.lib.secret "home" "private-env-vars.env";
  };
}
