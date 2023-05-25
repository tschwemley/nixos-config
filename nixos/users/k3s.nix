{ ... }: {
  users.users.k3s = {
    isNormalUser = true;
    description = " ";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
