_: prev: {
  linux-manual = prev.linux-manual.overrideAttrs {
    inherit (prev.linuxPackages_zen.kernel) src version;
  };
}
