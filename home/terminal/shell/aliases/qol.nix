{
  btop = "sudo btop";
  checkip = "curl https://ipinfo.io/ip";
  checkmullvad = "curl -sS https://am.i.mullvad.net/json | jq";
  dirsizes = "sudo du -h --max-depth=1 | sort -hr";
  gco = "git checkout";
  gcob = "git checkout -b";
  gcm = "git cm";
  gl = "git log";
  icat = "kitten icat";
  jl = "journalctl -xeu";
  lgroups = "bat /etc/group";
  lusers = "bat /etc/passwd";
  pwgen = "pwgen -N1 -snyr \]\[\|\?\{\}\(\)\'%\;~\"\<\>\`-\/=:, 12 | copy";
  randstr = "head /dev/urandom | tr -dc A-Za-z0-9 | head -c10";
  userctl = "systemctl --user";
}
