{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage {
  pname = "pomobar-rs";
  version = "652d428";

  src = fetchFromGitHub {
    owner = "liminchian";
    repo = "pomobar-rs";
    rev = "652d428";
    hash = "sha256-OLu/Q4qHSV7OB+Z/mlTwNkVsWmget22MTIubVpmKRM0=";
  };

  cargoPatches = [./Cargo.lock.patch];

  cargoHash = "sha256-mt8+VbaWtZA2Ja89X4fV2KYonv1ixNFUajPwEF21Ubs=";

  doCheck = false;

  meta = with lib; {
    description = "A Pomodoro timer application written in Rust";
    homepage = "https://github.com/liminchian/pomobar-rs";
    license = licenses.mit;
    # maintainers = [ maintainers.yourName ]; # Replace with your name or handle
  };
}
