{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    libguestfs
    qemu
    quickemu
  ];
}
