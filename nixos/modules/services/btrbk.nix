{
# see: https://nixos.wiki/wiki/Btrbk
services.btrbk = {
#extraPackages = [ pkgs.lz4 ];
  instances.remote = {
    onCalendar = "weekly";
    settings = {
      # ssh_identity = "/etc/btrbk_key"; # NOTE: must be readable by user/group btrbk
      # ssh_user = "btrbk";
      stream_compress = "lz4";
      volume."/btr_pool" = {
        target = "ssh://myhost/mnt/mybackups";
        subvolume = "nixos";
      };
    };
  };
};
}
