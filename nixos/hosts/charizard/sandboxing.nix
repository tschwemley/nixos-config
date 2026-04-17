# Contains nixos and home-manager options and programs that I'm trialing before committing to
{
  #######################################################
  ##                                                   ##
  ##  TODO: Testing section below... remove when done  ##
  ##                                                   ##
  #######################################################

  ## PACKAGES ##
  environment.systemPackages = with pkgs; [
    # ayugram-desktop
    shiori

    # TODO: move the below into home-manager and figure out where the fuck to categorize
    diffoscopeMinimal
  ];

  ## PROGRAMS ##
  programs.nix-ld.enable = true;

  ## SERVICES ##
  # services.n8n.enable = true;
  services.shiori.enable = true;
  # stoat.enable = true;
  # services.torrentstream.enable = true;

  ## HOME MANAGER ##
  home-manager.users.schwem = {
    #
    # TODO: move elsewhere
    imports = [
      ../../../home/programs/media/gallery-dl.nix
    ];

    programs.yt-dlp = {
      enable = true;

      package =
        with pkgs.python313Packages;
        yt-dlp.overridePythonAttrs (prev: {
          dependencies = prev.dependencies ++ [ beautifulsoup4 ];
        });
    };

    programs.zsh.shellAliases."yt-dlp" = "yt-dlp --cookies-from-browser firefox:~/.config/zen/default";

    # TODO: remove unused/move keeping items elsewhere
    home.packages = with pkgs; [
      drawio
      nicotine-plus
      super-productivity
    ];
  };
}
