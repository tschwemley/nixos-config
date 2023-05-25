{ disks ? [ "/dev/sda" ], lib, pkgs, ... }: 
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = builtins.elemAt disks 0;
        content = {
          type = "table";
          format = "gpt";
          partitions = [
            {
              name = "ESP";
              start = "1MiB";
              end = "100MiB";
              bootable = true;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";  
                mountOptions = [ "defaults" ];            
              };
            }
            {
              name = "luks";
              start = "100MiB";
              end = "100%";
              content = {
                type = "luks";
                name = "crypted";
                extraOpenArgs = [ "--allow-discards" ];
				keyFile = "/tmp/passphrase";
                content = {
                  type = "btrfs"; 
                  extraArgs = [ "-f" ];  
                  subvolumes = {                
                    "/" = {
                      mountOptions = [ "compress=ztsd" ];
                    };  
                    "/nix" = {
                      mountOptions = [ "compress=ztsd" "noatime" ];
					};  
                    "/persist" = {
                      mountOptions = [ "compress=ztsd" ];
					};  
                    "/swap" = {
                      mountOptions = [ "compress=ztsd" "noatime" ];
					};  
                  };  
                };
              };
            }  
          ];
        };
      };
    };
  }; 
  
  # boot.kernelParams = [
  #   "cryptdevice=/dev/disk/by-label/crypted:cryptroot" 
  # ];
  # 
  # fileSystems."/" = {
  #   device = "/dev/mapper/cryptroot";
  #   fsType = "btrfs";
  #   options = [ "subvol=rootfs", "autodefrag", "compress=zstd" ];
  # };
  # 
  # fileSystems."/home" = {
  #   device = "/dev/mapper/cryptroot";
  #   fsType = "btrfs";
  #   options = [ "subvol=home" ];  
  # };
  # 
  # fileSystems."/.snapshots" = {
  #   device = "/dev/mapper/cryptroot";
  #   fsType = "btrfs";
  #   options = [ "subvol=.snapshots" ];    
  # };
}
