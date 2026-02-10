{
  stdenv,
  acpica-tools,
  cpio,
}:

stdenv.mkDerivation {
  name = "cirrus-patch-dsdt";
  src = ./.;

  phases = [
    "unpackPhase"
    "installPhase"
  ];

  nativeBuildInputs = [
    acpica-tools
    cpio
  ];

  installPhase = ''
    mkdir -p $out/
    mkdir -p kernel/firmware/acpi

    iasl -p ./ux582_cirrus_patch -tc $src/ux582_cirrus_patch.dsl

    cp ux582_cirrus_patch.aml kernel/firmware/acpi
    find kernel | cpio -H newc --create > $out/ux582_cirrus_patch.cpio
  '';
}
