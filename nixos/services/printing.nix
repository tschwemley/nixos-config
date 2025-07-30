{
  hardware.printers = {
    ensureDefaultPrinter = "Brother_HL-L2340D";
    ensurePrinters = [
      {
        deviceUri = "ipp://192.168.1.33/ipp";
        location = "home";
        name = "Brother_HL-L2340D";
        model = "everywhere";
      }
    ];
  };

  services.printing.enable = true;

  systemd.services.ensure-printers = {
    after = ["NetworkManager-wait-online"];
    requires = ["NetworkManager-wait-online"];
  };
}
