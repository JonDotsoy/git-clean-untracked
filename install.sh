#!/usr/bin/env sh

VERSION="v0.1.0"
GITHUB_REPO="JonDotsoy/git-clean-untracked"
DIROUT="$HOME/.git-alias/git-forget"
ASSET_BROWSER_DOWNLOAD_URL="https://github.com/$GITHUB_REPO/releases/download/$VERSION/git-clean-untracked"
GIT_ALIAS_SCRIPT="!$DIROUT/git-clean-untracked"

mkdir -p $DIROUT
curl --location --request GET -o "$DIROUT/git-clean-untracked" $ASSET_BROWSER_DOWNLOAD_URL
chmod +x "$DIROUT/git-clean-untracked"

git config --global alias.clean-untracked $GIT_ALIAS_SCRIPT
git config --global alias.cu $GIT_ALIAS_SCRIPT
