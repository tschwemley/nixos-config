{pkgs, ...}: {
  imports = [./chrysalis];
  environment.systemPackages = with pkgs; [
    # open source gui and qmk fork -- udev built along with package
    vial
  ];
}
