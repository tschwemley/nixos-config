{
  programs.ssh.matchBlocks = builtins.listToAttrs (
    map
      (name: {
        inherit name;
        value = {
          hostname = name;
          user = "root";
        };
      })
      [
        "articuno"
        "zapados"
        "moltres"
        "eevee"
        "jolteon"
        "flareon"
        "tentacool"
      ]
  );
}
