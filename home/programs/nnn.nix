{...}: {
  programs.nnn = {
    enable = true;
    bookmarks = {
      D = "~/Downloads";
      p = "~/projects";
      n = "~/nixos-config";
    };
  };
}
