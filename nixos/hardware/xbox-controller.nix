{
  environment.sessionVariables = {
    SDL_JOYSTICK_HIDAPI = "0";
  };

  # REF: https://wiki.archlinux.org/title/Bluetooth#No_BLE_device_can_be_discovered_with_Intel_Corp._AX200_Bluetooth
  # REF: https://discourse.nixos.org/t/xbox-controller-stuck-in-a-disconnect-reconnect-loop/67845/6
  hardware = {
    bluetooth.settings.General = {
      Privacy = "device";
      JustWorksRepairing = "always";
      Class = "0x000100";
      FastConnectable = "true";

      # TODO: possibly add GATT?
    };

    # this option adds the extra modprobe config && kernel modules needed
    xpadneo.enable = true;
  };
}
