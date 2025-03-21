{pkgs, ...}: {
  # TODO: move/rename file appropriately and edit based on which tool(s) keeping in config
  home.packages = with pkgs; [
    dbgate
    schemacrawler
    schemaspy
    tbls
    usql # NOTE: 1,000,000 times yes. This may make copying so much easier
  ];
}
