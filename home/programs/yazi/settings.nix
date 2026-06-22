{
  # REF: https://yazi-rs.github.io/docs/configuration/overview
  settings = {
    mgr = {
      linemode = "mtime";
      show_hidden = true;
      show_symlink = true;
      sort_by = "alphabetical";
      sort_dir_first = true;
      sort_reverse = false;
      sort_sensitive = true;

      layout = [
        1
        4
        3
      ];
    };

    plugin = {
      prepend_preloaders = [
        {
          mime = "model/3mf";
          run = "f3d-preview";
        }
        {
          mime = "model/obj";
          run = "f3d-preview";
        }
        {
          mime = "model/ply";
          run = "f3d-preview";
        }
        {
          mime = "model/stl";
          run = "f3d-preview";
        }
        {
          mime = "model/step";
          run = "f3d-preview";
        }
      ];

      prepend_previewers = [
        {
          mime = "model/3mf";
          run = "f3d-preview";
        }
        {
          mime = "model/obj";
          run = "f3d-preview";
        }
        {
          mime = "model/ply";
          run = "f3d-preview";
        }
        {
          mime = "model/stl";
          run = "f3d-preview";
        }
        {
          mime = "model/step";
          run = "f3d-preview";
        }
      ];
    };
  };
}
