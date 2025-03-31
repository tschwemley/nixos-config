config:
/*
bash
*/
''
  source ${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh
  export PATH=$PATH:${config.home.profileDirectory}/bin

  check-help-flag() {
    local cmd="$1"
    if [[ "$cmd" =~ --help\b|-h\b ]]; then
      local base_cmd="''${cmd%% *}"
      eval "''${cmd%%--help*}" --help | ${pkgs.bat}/bin/bat --plain --language=help
      return 1  # Skip original execution
    fi
  }

  # nix build with output of last error
  func nbuild() {
    nix build "$@" 2>/tmp/last-build.error.log
    $(tail -n1 /tmp/last-build.error.log | sed "s/.*\(nix log.*\)'./\1/")
  }

  # run command from nixpkgs via current system flake
  func run() {
    pkg=$1
    shift

    nix run github:nixos/nixpkgs/nixos-unstable#"$pkg" -- "$@"
  }

  func srun() {
    pkg=$1
    shift

    sudo nix run github:nixos/nixpkgs/nixos-unstable#"$pkg" -- "$@"
  }

  # TODO: func needs fixed for extracting multiple keys. Not worth extra time when writing.
  func sops_extract() {
    # Assign all but the last argument as a secret key
    secretKeys=$(printf '"%s" ' "$\{@:1:$#-1}")


    # Assign the last argument as the secret path
    sopsFile="$\{*:$#}"
    echo "$sopsFile"

    # decrypt and extract the secret keys (`<str>% ` trims trailing space)
    sops -d --extract "'[$\{secretKeys% }]'" "$sopsFile"
  }



  # tail with bat
  func tailf() { tail -f "$1" | bat --paging=never -l log }
''
