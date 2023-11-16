{
  diskName,
  swapSize ? "-2G",
  ...
}: {
  disko = {
    devices = {
      disk = {
        main = {
          type = "disk";
          device = diskName;
          content = {
            type = "table";
            format = "gpt";
            partitions = [
              {
                name = "swap";
                start = swapSize;
                end = "100%";
                part-type = "primary";
                content = {
                  type = "swap";
                  randomEncryption = true;
                };
              }
            ];
          };
        };
      };
    };
  };
}
