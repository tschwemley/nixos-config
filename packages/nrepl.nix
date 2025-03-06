{writeShellScriptBin}:
writeShellScriptBin "nrepl" ''
  source /etc/set-environment
  nix repl -f ${./..}/repl.nix "$@"
''
