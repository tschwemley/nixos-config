{
  self,
  pkgs,
  ...
}: {
  imports = [self.inputs.spicetify-nix.homeManagerModules.spicetify];

  # home.packages = with pkgs; [
  #   librespot
  #   mopidy
  #   # spicetify-cli
  #   spotify
  #   spot
  # ];

  # REF: https://gerg-l.github.io/spicetify-nix/
  programs.spicetify = let
    # For Flakeless:
    # spicePkgs = spicetify-nix.packages;
    # With flakes:
    spicePkgs = self.inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
  in {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      # adblockify
      addToQueueTop
      allOfArtist
      bestMoment
      betterGenres
      copyToClipboard
      hidePodcasts
      keyboardShortcut # REF: https://spicetify.app/docs/advanced-usage/extensions/#keyboard-shortcut
      phraseToPlaylist
      powerBar
      queueTime
      sectionMarker
      shuffle # shuffle+ (special characters are sanitized out of extension names)
      skipStats
      songStats
      # volumeProfiles
      wikify
      writeify
    ];
    theme = spicePkgs.themes.text;
  };
}
