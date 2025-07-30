{config, ...}: {
  boot = { 
    extraModulePackages = [config.boot.kernelPackages.xpadneo]; 
    extraModprobeConfig = "options bluetooth disable_ertm=Y"; 
  };

  hardware = {
    bluetooth.settings.General = {
      experimental = true;

      # https://www.reddit.com/r/NixOS/comments/1ch5d2p/comment/lkbabax/
      # for pairing bluetooth controller
      Privacy = "device";

      JustWorksRepairing = "always";
      Class = "0x000100";
      FastConnectable = true;
    };
    xpadneo.enable = true;
  };
}
