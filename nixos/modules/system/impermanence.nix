{
  inputs,
  additionalDirs ? [],
  additionalFiles ? [],
  ...
}: {
  imports = [inputs.impermanence.nixosModule];

  environment.persistence = {
    "/persist" = {
      directories =
        [
          "/etc/ssh"
          "/var/log"
        ]
        ++ additionalDirs;

      files =
        [
          "/etc/machine-id"
        ]
        ++ additionalFiles;
    };
  };
}
