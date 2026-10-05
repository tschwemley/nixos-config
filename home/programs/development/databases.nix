{ pkgs, ... }:
{
  imports = [ ./lazysql.nix ];

  # TODO: move/rename file appropriately and edit based on which tool(s) keeping in config
  home.packages = with pkgs; [
    dbgate
    mariadb
    sqlite-interactive

    # TODO: evaluate below options; delete unwanted items
    jailer
    schemacrawler
    schemaspy
    tbls
  ];
}
