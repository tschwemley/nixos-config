# {pkgs, ...}: {
#   home.packages = with pkgs; [bambu-studio];
# }
{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [inputs.nixpkgs-master.legacyPackages.${pkgs.system}.bambu-studio];
}
