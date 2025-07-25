return {
   settings = {
      intelephense = {
         files = {
            exclude = {
               "**/.git/**",
               "**/.svn/**",
               "**/.hg/**",
               "**/CVS/**",
               "**/.DS_Store/**",
               "**/node_modules/**",
               "**/bower_components/**",
               "**/vendor/**/{Tests,tests}/**",
               "**/.history/**",
               "**/vendor/**/vendor/**",
               "/nix/store/**",
            },
         },
         references = {
            exclude = {
               "/nix/store/**",
            },
         },
      },
   },
}
