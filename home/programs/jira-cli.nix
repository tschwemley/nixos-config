{pkgs, ...}: {
  home.packages = with pkgs; [
    jira-cli-go
    go-jira
  ];
}
