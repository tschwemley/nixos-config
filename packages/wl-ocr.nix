{
  writeShellScriptBin,
  lib,
  grim,
  libnotify,
  slurp,
  tesseract5,
  wl-clipboard,
}: let
  _ = lib.getExe;
in
  writeShellScriptBin "wl-ocr" ''
    ${_ grim} -g "$(${_ slurp})" -t ppm - | ${_ tesseract5} -l eng - - | ${wl-clipboard}/bin/wl-copy
    echo "$(${wl-clipboard}/bin/wl-paste)"
    ${_ libnotify} -- "$(${wl-clipboard}/bin/wl-paste)"
  ''
# copied from: https://github.com/fufexan/dotfiles/blob/5abec701781430b374a0cb38eec11308cbc347a9/pkgs/wl-ocr/default.nix#L13
