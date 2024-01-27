{pkgs, ...}: {
  disko = pkgs.writeShellScript "disko" (builtins.readFile ./disko.sh);
}
