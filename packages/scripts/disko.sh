SCRIPT_DIR=$(dirname "$0")

while [[ $# -gt 0 ]]; do
	case "$1" in
		-m | --mode)
			mode=$2
			shift
			;;
		-p | --profile)
	esac
	shift
done

echo "nyx"

echo $mode
exit 1

fPrefix="${dirName}/../../nixos/hardware/disks"
file="${fPrefix}/ephemeral-root.nix"

nix run \ --experimental-features 'nix-command flakes' github:nix-community/disko -- \
	-m $mode \
	--arg diskName '"$diskName"' \
	$file
