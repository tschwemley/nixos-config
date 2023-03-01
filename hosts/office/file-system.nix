{
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/5ac9fe41-4608-425e-8394-a7138b741b97";
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/9109-A820";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/a12280b1-827f-4e67-adf4-df2344a792cc"; }
    ];
}
