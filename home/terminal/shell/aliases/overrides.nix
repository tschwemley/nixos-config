{
  cat = "bat -pp";
  copy = "wl-copy";
  logout = "loginctl terminate-session \${XDG_SESSION_ID:-}";
}
