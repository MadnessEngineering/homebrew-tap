#!/bin/sh
# Point the madness-desktop cask at a published release.
#
#   scripts/bump-madness-desktop.sh 0.1.4
#
# Downloads the release zip, hashes it, and rewrites version + sha256 in the
# cask. Review the diff, then commit and push.
set -eu

VERSION="${1:?usage: $0 <version, e.g. 0.1.4>}"
VERSION="${VERSION#v}"
CASK="$(dirname "$0")/../Casks/madness-desktop.rb"
URL="https://github.com/MadnessEngineering/madnessDesktop/releases/download/v${VERSION}/MadnessDesktop-${VERSION}-darwin-arm64.zip"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT INT TERM

echo "bump: downloading $URL"
curl -fSL --progress-bar "$URL" -o "$TMP/release.zip"
SHA="$(shasum -a 256 "$TMP/release.zip" | cut -d ' ' -f 1)"

sed -i '' \
  -e "s/^  version \".*\"/  version \"${VERSION}\"/" \
  -e "s/^  sha256 \".*\"/  sha256 \"${SHA}\"/" \
  "$CASK"

echo "bump: madness-desktop -> ${VERSION} (sha256 ${SHA})"
