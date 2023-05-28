{ ... }: 
{
  users.users.schwem = {
    isNormalUser = true;
    description = " ";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager.users.schwem = self.homeConfigurations.personal;

  # Enable automatic login for the user.
  #TODO: this might make more sense in the section managing the wm
  services.getty.autologinUser = "schwem";
}
