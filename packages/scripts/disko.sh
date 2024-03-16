SCRIPT_DIR=$(dirname "$0")

while [[ $# -gt 0 ]]; do
	case "$1" in
		-m | --mode)
			mode=$2
			shift
			;;
		-p | --profile)
			if [[ $2 == "buyvm" ]] ; then
				diskName="/dev/vda"	
			elif [[ $2 == "buyvmWithStorage" ]] ; then
				diskName="/dev/vda"	
				storageDisk="/dev/sda"
			elif [[ $2 == "proxmox" ]] ; then
				diskName="/dev/sda"	
				storageDiskName="/dev/sdb"
			else 
				echo "invalid profile"
				exit 1
			fi

	esac
	shift
done

[[ -z "$mode" || -z "$diskName" ]] && echo "both [-m | --mode] and [-p | --profile] must be passed in and valid" && exit 1


fPrefix="${SCRIPT_DIR}/../../nixos/hardware/disks"
rootFile="${fPrefix}/ephemeral-root.nix"
storageFile="${fPrefix}/block-storage.nix"

nix run \ --experimental-features 'nix-command flakes' github:nix-community/disko -- \
	-m $mode \
	--arg diskName '"$diskName"' \
	$rootFile

if [[ ! -z "$storageDisk" ]] ; then 
	nix run \ --experimental-features 'nix-command flakes' github:nix-community/disko -- \
		-m $mode \
		--arg diskName '"$storageDiskName"' \
		$storageFile
fi
