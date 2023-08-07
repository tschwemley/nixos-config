# TODO: convert this to a nix pkg/app
# see: https://github.com/NixOS/nix/issues/2735
mount -o remount,rw /nix/store
xargs -r0a <(find /nix/store -type f ! -path '/nix/store/.links/*' -print0 ) bash -c ' for file do dd if="$file" bs=1M of=/dev/null status=none ; if [ $? == 1 ]; then echo "$file"; else echo $file OKAY > /dev/stderr; fi; done' > ioerror.log
while read file; do rm "$file"; done < ioerror.log
rm ioerror.log
nix-store --verify --check-contents --repair
mount -o remount,r /nix/store
