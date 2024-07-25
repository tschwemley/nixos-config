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
				useGrub=true
			elif [[ $2 == "buyvmWithStorage" ]] ; then
				diskName="/dev/vda"	
				storageDisk="/dev/sda"
				useGrub=true
			elif [[ $2 == "proxmox" ]] ; then
				diskName="/dev/sda"	
				storageDisk="/dev/sdb"
				useGrub=false
			elif [[ $2 == "proxmox-b" ]] ; then
				diskName="/dev/sdb"	
				storageDisk="/dev/sda"
				useGrub=false
			else 
				echo "invalid profile"
				exit 1
			fi

	esac
	shift
done

if [[ -z "$mode" || -z "$diskName" || -z "$useGrub" ]] ; then
	echo "both [-m | --mode] and [-p | --profile] must be passed in and valid" 
	exit 1
fi

fPrefix="${SCRIPT_DIR}/../../nixos/hardware/disks"
rootFile="${fPrefix}/ephemeral-root.nix"
storageFile="${fPrefix}/block-storage.nix"

nix --experimental-features 'nix-command flakes' run github:nix-community/disko -- \
	-m "$mode" \
	--arg diskName "$diskName" \
	"$rootFile"

if [[ -n "$storageDisk" ]] ; then 
	nix --experimental-features 'nix-command flakes' run github:nix-community/disko -- \
		-m "$mode" \
		--arg diskName "$storageDisk" \
		"$storageFile"
fi


# nix --experimental-features 'nix-command flakes' run github:nix-community/disko -- \
# 	-m disko \
# 	--arg diskName '"/dev/sda"' \
# 	--arg useGrub false \
# 	./nixos/hardware/disks/ephemeral-root.nix

# nix --experimental-features 'nix-command flakes' run github:nix-community/disko -- \
# 	-m disko \
# 	--arg diskName '"/dev/sda"' \
# 	--arg useGrub false \
# 	./nixos/hardware/disks/ephemeral-root.nix
