_: prev: {
  visidata = prev.visidata.overridePythonAttrs (oldAttrs: {
    propagatedBuildInputs = with prev.python313Packages;
      (oldAttrs.propagatedBuildInputs or [])
      ++ [
        ibis-framework
        mysqlclient
        pyarrow-hotfix
      ];

    postInstall =
      (oldAttrs.postInstall or "")
      + ''
        echo "Copying vdsql to $out/bin"
        cp visidata/apps/vdsql/vdsql $out/bin/vdsql
      '';
  });
}
