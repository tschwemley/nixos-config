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
		  #"/etc/systemd/network"
		  "/etc/ssh"
          "/var/log"
        ]
        ++ additionalDirs;

      files =
        [
		  "/var/run/secrets.d/age-keys.txt"
          "/etc/machine-id"
          "/etc/nix/id_rsa"
        ]
        ++ additionalFiles;
    };
	
    "/home" = {
      directories = [
        "/home"
      ];
    };
  };
}
