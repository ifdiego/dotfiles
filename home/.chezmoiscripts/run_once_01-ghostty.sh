#!/usr/bin/env bash
set -eu

echo ""
if command -v ghostty &> /dev/null
then
    echo "Ghostty is already installed"
else
    echo "--- Installing ghostty ---"
    . /etc/os-release
    curl -fsSL "https://copr.fedorainfracloud.org/coprs/scottames/ghostty/repo/fedora-${VERSION_ID}/scottames-ghostty-fedora-${VERSION_ID}.repo" | sudo tee /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:scottames:ghostty.repo > /dev/null
    rpm-ostree refresh-md
    rpm-ostree install ghostty
fi
