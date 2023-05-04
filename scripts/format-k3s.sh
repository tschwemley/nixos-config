# TODO: make this take args
root = sda

# NOTE: this script assumes paritioning prior to running

# setup encryption for root drive
cryptsetup -y -v luksFormat /dev/$root

# open encryption so we can perform ops on the drive
cryptsetup open /dev/$root root

mkfs.btrfs /dev/mapper/root

mkdir /tmp/root
mount /dev/mapper/root -o compress-force=zstd,noatime,ssd /tmp/root

cd /tmp/root
btrfs subvolume create nix
btrfs subvolume create home
btrfs subvolume create persist
btrfs subvolume create nixos-config

mount -t tmpfs none /mnt

mkdir /mnt/{boot,nix,home,persist}
mkdir /mnt/etc/nixos

mount /dev/<boot-partition> /mnt/boot

mount /dev/mapper/root -o compress-force=zstd,noatime,ssd,subvol=nix /mnt/nix
mount /dev/mapper/root -o compress-force=zstd,noatime,ssd,subvol=home /mnt/home
mount /dev/mapper/root -o compress-force=zstd,noatime,ssd,subvol=persist /mnt/persist

mount /dev/mapper/root -o compress-force=zstd,noatime,ssd,subvol=nixos-config /mnt/etc/nixos

# generate the nix config to the 
nixos-generate-config --root /mnt



# see: 
# https://hanckmann.com/posts/nixos-and-erasing-my-darlings/

