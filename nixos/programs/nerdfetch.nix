{pkgs, ...}: {
  environment.systemPackages = with pkgs; [nerdfetch];
}
