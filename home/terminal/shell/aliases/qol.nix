{
  btop = "sudo btop";
  cat = "bat -pp";
  checkip = "curl https://ipinfo.io/ip";
  nixconf = "cd ~/nixos-config";
  notes = "nvim -c 'Neorg workspace notes' -c 'Neorg journal today'";
  l = "ls";
  ll = "ls -alh";
  randstr = "head /dev/urandom | tr -dc A-Za-z0-9 | head -c10";
  userctl = "systemctl --user";
}
