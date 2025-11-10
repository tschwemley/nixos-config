{
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        softrealtime = "on";
      };

      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        amd_performance_level = "high";
        gpu_device = "1";
      };
    };
  };
}
