#!/usr/bin/env sh

VERSION="v0.0.1-beta.1"
GITHUB_REPO="JonDotsoy/git-forget"
GITHUB_REF_DOWNLOAD="https://api.github.com/repos/$GITHUB_REPO/tarball/$VERSION"
DIROUT="$HOME/.alias/git-forget"
FILEOUT="$DIROUT/d-$VERSION.tar.gz"
GIT="git@github.com:JonDotsoy/git-forget.git"

# mkdir -p $DIROUT
# echo curl -L $GITHUB_REF_DOWNLOAD -o $FILEOUT
# tar xvf -C $DIROUT $FILEOUT

# curl \
#     -H "Accept: application/vnd.github.v3+json" \
#     https://api.github.com/repos/JonDotsoy/git-forget/contents/git-forget.bash?ref=$VERSION

git clone $GIT $DIROUT || {
    echo "Already cloned"
}

cd $DIROUT

git fetch &&
    git checkout $VERSION

echo "============================================================"
echo ""
echo "Copy the next line into .zshrc, .bashrc or .shrc:"
echo ""
echo "source $DIROUT/git-forget.bash"
echo ""
