# let
#   programs = lib.makeBinPath [
#     config.programs.hyprland.package
#     pkgs.coreutils
#   ];
#
#   startscript = pkgs.writeShellScript "gamemode-start" ''
#     export PATH=$PATH:${programs}
#     export HYPRLAND_INSTANCE_SIGNATURE=$(ls -1 /tmp/hypr | tail -1)
#     hyprctl --batch 'keyword decoration:blur 0 ; keyword animations:enabled 0 ; keyword misc:vfr 0'
#   '';
#
#   endscript = pkgs.writeShellScript "gamemode-end" ''
#     export PATH=$PATH:${programs}
#     export HYPRLAND_INSTANCE_SIGNATURE=$(ls -1 /tmp/hypr | tail -1)
#     hyprctl --batch 'keyword decoration:blur 1 ; keyword animations:enabled 1 ; keyword misc:vfr 1'
#   '';
# in
{
  # programs.gamemode = {
  #   enable = true;
  #   capSysNice = true;
  #   args = [
  #     "--rt"
  #     "--expose-wayland"
  #   ];
  #   # settings = {
  #   #   custom = {
  #   #     start = startscript.outPath;
  #   #     end = endscript.outPath;
  #   #   };
  #   #   general = {
  #   #     softrealtime = "auto";
  #   #     renice = 15;
  #   #   };
  #   #   gpu = {
  #   #     apply_gpu_optimisations = "accept-responsibility";
  #   #     amd_performance_level = "high";
  #   #     gpu_device = 1;
  #   #   };
  #   # };
  # };
}
