{pkgs, ...}: {
  environment.systemPackages = [pkgs.go];
  # this is necessary so that delve can attach to remote processes (e.g. a running server binary)
  security.wrappers.delve = {
    owner = "root";
    group = "users";
    program = "dlv";
    source = "${pkgs.delve}/bin/dlv";
    capabilities = "cap_sys_ptrace+p";
  };
}
