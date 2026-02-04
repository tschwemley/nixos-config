{
  buildNpmPackage,
  fetchFromGitHub,
  importNpmLock,
  sentry-cli,
}:
let
  src = fetchFromGitHub {
    owner = "raindropio";
    repo = "app";
    rev = "latest";
    hash = "sha256-IrVqM1jMQlSmR430f9ubnYMYTcnYHflAzzrivvSlEJY=";
  };

  npmHooks = importNpmLock { npmRoot = src; };
in
buildNpmPackage {
  inherit src;
  inherit (importNpmLock) npmConfigHook;

  name = "raindrop";
  version = "5.6.94";

  nativeBuildInputs = [ sentry-cli ];

  npmDeps = importNpmLock { npmRoot = src; };

  npmConfigHook = ''
    export SENTRY_CLI=${sentry-cli}/bin/sentry-cli                 
    ${npmHooks.npmConfigHook}                                      
  '';

  # The prepack script runs the build script, which we'd rather do in the build phase.
  npmPackFlags = [ "--ignore-scripts" ];
}
