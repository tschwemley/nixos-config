{...}: {
  services.cloudflared = {
    enable = true;
    tunnels."f7eaa2f2-9157-4f3e-978e-f7eeee830b5e" = {
    };
  };
}
