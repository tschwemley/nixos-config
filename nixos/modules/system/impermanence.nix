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
          "/var/run/secrets.d/age-keys.txt"
          # "/etc/machine-id"
        ]
        ++ additionalFiles;
    };
  };
}
