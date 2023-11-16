# Set default values
boot=$1
root=$2

if [ "$#" -ne 2 ]; then
  echo "Error: This script requires exactly two arguments." >&2
  echo "Usage: ./format-for-impermanence.sh <boot> <root>" >&2
  exit 1
fi

# Create the partition table and partitions with parted
parted -a optimal /dev/$boot <<EOF
unit mib
mklabel gpt
mkpart ESP fat32 1 513
set 1 boot on
mkpart primary 513 100%
quit
EOF

# Format the ESP partition with the FAT32 filesystem
mkfs.fat -F32 /dev/${boot}1


# encrypt the root partition with luks and open
cryptsetup -y -v luksFormat /dev/$root
cryptsetup open /dev/$root root

# create btrfs file system and mount to tmp
mkfs.btrfs /dev/mapper/root

mkdir /tmp/root
mount /dev/mapper/root -o compress-force=zstd,noatime,ssd /tmp/root

# create the btrfs subvolumes for the data to persist
cd /tmp/root
btrfs subvolume create nix
btrfs subvolume create home
btrfs subvolume create persist
btrfs subvolume create nixos-config

# create and mount the dirs for the subvolumes
mount -t tmpfs none /mnt

mkdir /mnt/{boot,nix,home,persist}
mkdir /mnt/etc/nixos

mount /dev/${boot}1 /mnt/boot

mount /dev/mapper/root -o compress-force=zstd,noatime,ssd,subvol=nix /mnt/nix
mount /dev/mapper/root -o compress-force=zstd,noatime,ssd,subvol=home /mnt/home
mount /dev/mapper/root -o compress-force=zstd,noatime,ssd,subvol=persist /mnt/persist

mount /dev/mapper/root -o compress-force=zstd,noatime,ssd,subvol=nixos-config /mnt/etc/nixos

