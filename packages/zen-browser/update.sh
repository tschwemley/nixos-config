#!/usr/bin/env -S nix shell nixpkgs#jq -c bash

set -euo pipefail

# TODO: modify this script to work with this embedded version (used to be via flake)
regex="^[0-9]\.[0-9]\.[0-9].*$"

info="info.json"
oldversion=$(jq -rc '.version' "$info")

url="https://api.github.com/repos/zen-browser/desktop/releases?per_page=1"
version="$(curl -s "$url" | jq -rc '.[0].tag_name')"

if [ "$oldversion" != "$version" ] && [[ "$version" =~ $regex ]]; then
  echo "Found new version $version"
  sharedUrl="https://github.com/zen-browser/desktop/releases/download"

  genericUrl="${sharedUrl}/${version}/zen.linux-generic.tar.bz2"
  specificUrl="${sharedUrl}/${version}/zen.linux-specific.tar.bz2"

  # perform downloads in parallel
  echo "Prefetching files..."
  nix store prefetch-file "$genericUrl" --log-format raw --json | jq -rc '.hash' >/tmp/genericHash &
  nix store prefetch-file "$specificUrl" --log-format raw --json | jq -rc '.hash' >/tmp/specificHash &
  wait
  genericHash=$(</tmp/genericHash)
  specificHash=$(</tmp/specificHash)

  echo '{"version":"'"$version"'","generic":{"hash":"'"$genericHash"'","url":"'"$genericUrl"'"},"specific":{"hash":"'"$specificHash"'","url":"'"$specificUrl"'"}}' >"$info"
else
  echo "zen is up to date"
fi
