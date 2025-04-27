{
  hueforge,
  appimageTools,
}:
appimageTools.wrapType2 rec {
  pname = "hueforge";
  version = "0.9.0-beta-1";
  src = hueforge;
  # src = builtins.path {
  #   path = ./HueForge_v0.9.0-beta-1.AppImage;
  #   name = "${pname}-${version}";
  # };

  # src = "file:///home/schwem/nixos-config/packages/hueforge/HueForge_Linux_v${version}.AppImage";
  # src = builtins.fetchTarball {
  #   url = "file:///home/schwem/nixos-config/packages/hueforge/HueForge_Linux_v${version}.AppImage";
  #   sha256 = "sha256:1n7ixsdp1a9mv8w560zx42cmib7dg0scp36nvwgck44dn47h9zh4";
  # };
}
