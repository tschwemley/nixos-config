{ pkgs, ... }:
{
  home.packages = [ pkgs.reddit-tui ];
  xdg.configFile."reddittui/reddittui.toml".text = # toml
    ''
      # Core configuration
      [core]
      bypassCache = false
      logLevel = "Warn"

      # Filter out posts containing keywords or belonging to certain subreddits
      [filter]
      # subreddits = ["news", "politics"]
      # keywords = ["pizza", "pineapple"]

      # Configure client timeout and cache TTL. By default, subreddit posts and comments are cached for 1 hour.
      [client]
      timeoutSeconds = 10
      cacheTtlSeconds = 3600

      # Configure which reddit server to use. Default is old.reddit.com but redlib servers are also supported
      [server]
      domain = "reddit.schwem.io"
      type = "redlib"
    '';
}
