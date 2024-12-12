{self', ...}: {
  # Ensure system nixpkgs has overlays as well not just pkgs module arg
  nixpkgs = {
    config.allowUnfree = true;
    overlays = import ../../overlays self';
  };
}
