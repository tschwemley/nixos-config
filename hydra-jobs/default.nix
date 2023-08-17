{self, ...}: {
  flake.hydraJobs = {
    inherit (self) packages;
  };
}
