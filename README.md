# Pre-Install
Before installing drives must be partitioned and formatted. Since I'm using 
ZFS the pool must be created as well.

System state is removed upon every boot. For the reasoning on why see: (Erase your Darlings)[https://grahamc.com/blog/erase-your-darlings/]

## Format Drives
```
#!/bin/bash
set -e

DEVICE=$1

# Wipe the disk
wipefs -a "${DEVICE}"

# Create partitions using parted
parted -a optimal --script "${DEVICE}" \
    unit mib \
    mklabel gpt \
    mkpart ESP fat32 1 513 \
    set 1 boot on \
    mkpart primary 513 100% \
    quit

echo "Partitioning completed."

mkfs.fat -F 32 -n boot $DEVICE
echo "Boot drive formatted."
```

## Create ZFS pool
```
zpool create \
    -o ashift=12 \
    -o autotrim=on \
    -O acltype=posixacl \
    -O atime=off \
    -O canmount=off \
    -O compression=zstd \
    -O dnodesize=auto \
    -O normalization=formD \
    -O xattr=sa \
    -O mountpoint=none \
    -O encryption=on \
    -O keylocation=prompt \
    -O keyformat=passphrase \
    rpool /dev/disk/by-id/<disk>

zfs create -p -o refreservation=1G -o mountpoint=none rpool/local/reserved
zfs create -p rpool/local/nix
zfs create -p rpool/safe/persist
```

## Mount the drives
```
DEVICE=$1

mount -t tmpfs none /mnt
mkdir -p /mnt/{boot,nix,persist}

mount "${DEVICE}" /mnt/boot
mount -t zfs -o zfsutil rpool/local/nix /mnt/nix
mount -t zfs -o zfsutil rpool/safe/persist /mnt/persist
```

# Architecture
home
nixos
packages
secrets
templates

TODO: consdider switching to: modules, hosts, users, containers?

