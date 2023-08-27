{...}: {
  perSystem = {
    lib,
    pkgs,
    ...
  }: {
    apps.default = {
      type = "app";
      program = pkgs.writeShellScriptBin "nix-utils" (lib.fileContents ./scripts/nix-utils.sh);
    };
  };
}
