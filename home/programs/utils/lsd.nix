{ pkgs, ... }:
{
  programs.lsd = {
    enable = true;
    enableZshIntegration = true;

    # REF: https://github.com/lsd-rs/lsd?tab=readme-ov-file#color-theme-file-content
    colors = {
      user = "bright_gray";
      group = "bright_cyan";

      permission = {
        read = "dark_green";
        write = "dark_yellow";
        exec = "dark_red";
        "exec-sticky" = "bright_magenta";
        "no-access" = 245;
        octal = 6;
        acl = "dark_cyan";
        context = "cyan";
      };

      date = {
        "hour-old" = 40;
        "day-old" = 42;
        older = 36;
      };

      size = {
        none = 245;
        small = 229;
        medium = 216;
        large = 172;
      };

      inode = {
        valid = 13;
        invalid = 245;
      };

      links = {
        valid = 13;
        invalid = 245;
      };

      "tree-edge" = 245;

      "git-status" = {
        default = 245;
        unmodified = 245;
        ignored = 245;
        "new-in-index" = "dark_green";
        "new-in-workdir" = "dark_green";
        typechange = "dark_yellow";
        deleted = "dark_red";
        renamed = "dark_green";
        modified = "dark_yellow";
        conflicted = "dark_red";
      };
    };

    # REF: https://github.com/Peltoche/lsd#config-file-content
    # settings = {};
  };
}
