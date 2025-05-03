{
  buildNpmPackage,
  fetchFromGitHub,
  importNpmLock,
  node-gyp,
  node-pre-gyp,
  nodejs_23,
  pkg-config,
  typescript,
  vips,
}: let
  nodejs = nodejs_23;
in
  buildNpmPackage rec {
    pname = "dgm.js";
    version = "0.38.4";

    src = fetchFromGitHub {
      owner = "dgmjs";
      repo = "dgmjs";
      tag = "v${version}";
      hash = "sha256-46Cac1XVFo9+F1/JFhkq6zkqoUmqYqyYbYZS4P8c2F8=";
    };

    nativeBuildInputs = [
      node-gyp
      node-pre-gyp
      nodejs
      pkg-config
      typescript
      vips
    ];

    npmDeps = importNpmLock {
      npmRoot = src;
    };

    # Force using system libvips and prevent downloads
    SHARP_FORCE_GLOBAL_LIBVIPS = "1";
    npm_config_sharp_libvips_binary_host = "";
    npm_config_sharp_binary_host = "";
    
    npmConfigHook = importNpmLock.npmConfigHook;

    # Configure node-gyp to use our node headers
    configurePhase = ''
      runHook preConfigure
      export HOME=$(mktemp -d)
      mkdir -p $HOME/.node-gyp/${nodejs.version}
      echo 9 > $HOME/.node-gyp/${nodejs.version}/installVersion
      ln -sfv ${nodejs}/include $HOME/.node-gyp/${nodejs.version}
      export npm_config_nodedir=${nodejs}
      export npm_config_node_gyp=${node-gyp}/lib/node_modules/node-gyp/bin/node-gyp.js
      runHook postConfigure
    '';

    # The prepack script runs the build script, which we'd rather do in the build phase.
    npmPackFlags = ["--workspace=apps/demo" "--ignore-scripts"];

    buildPhase = ''
      runHook preBuild
      
      # Build with system libvips
      SHARP_FORCE_GLOBAL_LIBVIPS=1 npm_config_sharp_libvips_binary_host="" \
        npm_config_sharp_binary_host="" npm run build --workspaces

      runHook postBuild
    '';

    # buildPhase = ''
    #   runHook preBuild
    #
    #   cd apps/demo
    #   npm install
    #   npm run build
    #
    #   runHook postBuild
    # '';
  }
