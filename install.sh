#!/usr/bin/env sh

VERSION="v0.0.1-beta.0"
GITHUB_REPO="JonDotsoy/git-forget"
GITHUB_REF_DOWNLOAD="https://api.github.com/repos/$GITHUB_REPO/tarball/$VERSION"
DIROUT="$HOME/.alias/git-forget"
FILEOUT="$DIROUT/d-$VERSION.tar.gz"

# mkdir -p $DIROUT
# echo curl -L $GITHUB_REF_DOWNLOAD -o $FILEOUT
# tar xvf -C $DIROUT $FILEOUT

curl \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/repos/JonDotsoy/git-forget/contents/git-forget.bash
