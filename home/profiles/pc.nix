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
    ../programs/development/databases.nix
    ../programs/development/lg-webos.nix
    ../programs/media
    ../programs/music
    ../programs/productivity
    ../programs/terminal

    ../programs/bitwarden.nix
    ../programs/cowsay.nix
    ../programs/displaycal.nix
    ../programs/glow.nix
    ../programs/gtk.nix
    ../programs/lan-mouse.nix
    ../programs/qt.nix
    ../programs/reddit-tui.nix
    ../programs/rustdesk.nix
    ../programs/wayland
    ../programs/wofi.nix
    ../programs/zathura.nix

    ../services/kdeconnect.nix
    ../services/mpris-proxy.nix
    ../services/udiskie.nix

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
    git.settings.url = {
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
