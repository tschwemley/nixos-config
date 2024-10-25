{
  btop = "sudo btop";
  cat = "bat -pp";
  checkip = "curl https://ipinfo.io/ip";
  copy = "wl-copy";
  dirsizes = "sudo du -h --max-depth=1 | sort -hr";
  nixconf = "cd ~/nixos-config";
  notes = "nvim -c 'Neorg workspace notes' -c 'Neorg journal today'";
  l = "ls";
  ll = "ls -alh";
  randstr = "head /dev/urandom | tr -dc A-Za-z0-9 | head -c10";

  # see: https://so.schwem.io/questions/13713101/rsync-exclude-according-to-gitignore-hgignore-svnignore-like-filter-c
  rsync = "rsync -vhra --include='**.gitignore' --exclude='/.git' --filter=':- .gitignore' --delete-after";

  # ssh = "kitty +kitten ssh";
  userctl = "systemctl --user";
}
