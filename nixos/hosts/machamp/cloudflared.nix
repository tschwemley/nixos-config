{pkgs, ...}: {
  environment.systemPackages = with pkgs; [cloudflared];
  services.cloudflared = {
    enable = true;
    tunnels = {
      "e93bb154-fb83-4bf4-a87d-2b0a56b12c34" = {
        credentialsFile = "/root/.cloudflared/e93bb154-fb83-4bf4-a87d-2b0a56b12c34.json";
        default = "http_status:404";
        ingress = {
          "build.schwem.io" = {
            hostname = "build.schwem.io";
            service = "localhost:3000";
          };
        };
      };
    };
  };
}
