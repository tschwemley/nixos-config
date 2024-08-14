diskName: partitions: {
  imports = [./common.nix];
  disko.devices.disk.main = {
    type = "disk";
    device = diskName;
    content = {
      inherit partitions;
      type = "gpt";
    };
  };
}
