# {pkgs, ...}: {
  # environment.systemPackages = with pkgs; [
  #   jellyfin
  #   jellyfin-ffmpeg
  #   jellyfin-web
  # ];
{
  services.jellyfin = {
    enable = true;
    jellyseerr.enable = true;
    openFirewall = true;
  };
}
