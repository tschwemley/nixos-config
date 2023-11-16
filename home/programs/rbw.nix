{config, ...}: {
  programs.rbw = {
    enable = true;
    settings.email = builtins.readFile "$XDG_RUNTIME_DIR/bw_email";
  };
}
