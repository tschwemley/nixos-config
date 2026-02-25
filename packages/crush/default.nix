{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule (finalAttrs: {
  pname = "crush";
  version = "0.45.0";

  src = fetchFromGitHub {
    owner = "charmbracelet";
    repo = "crush";
    tag = "v${finalAttrs.version}";
    hash = "sha256-fr8R00JM3bd+L/S809BhVma5y3fbaR9bR5x0atAPtqY=";
  };

  vendorHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";

  ldflags = [
    "-s"
    "-w"
    "-X=github.com/charmbracelet/crush/internal/version.Version=${finalAttrs.version}"
  ];

  meta = {
    description = "Glamourous agentic coding for all";
    homepage = "https://github.com/charmbracelet/crush";
    license = lib.licenses.fsl11Mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "crush";
  };
})
