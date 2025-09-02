{
  self,
  pkgs,
  ...
}:
{
  imports = [ self.inputs.spicetify-nix.homeManagerModules.spicetify ];

  # REF: https://gerg-l.github.io/spicetify-nix/
  programs.spicetify =
    let
      spicePkgs = self.inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
    in
    {
      enable = true;

      enabledExtensions = with spicePkgs.extensions; [
        # allOfArtist
        # autoSkip
        # beautifulLyrics
        # betterGenres
        # bookmark
        # fullAlbumDate
        # goToSong
        hidePodcasts
        # history
        # listPlaylistsWithSong
        # keyboardShortcut # REF: https://spicetify.app/docs/advanced-usage/extensions/#keyboard-shortcut
        # phraseToPlaylist
        # playlistIntersection
        # playNext
        # powerBar
        # seekSong
        # showQueueDuration
        # shuffle
        # songStats
        # starRatings
        # trashbin
        # wikify
        # writeify
      ];

      theme = spicePkgs.themes.onepunch;
    };
}
