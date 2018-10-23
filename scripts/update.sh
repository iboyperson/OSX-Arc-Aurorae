ROOT_DIR="$(dirname $0)/.."
CACHE_DIR="$ROOT_DIR/.cache"
ARC_DIR="$ROOT_DIR/OSX-Arc"
ARC_DARK_DIR="$ROOT_DIR/OSX-Arc-Dark"

echo "==== Fetching Repos ===="
if [ -d "$CACHE_DIR/arc-kde" ]; then
    git -C "$CACHE_DIR/arc-kde" pull
else
    git clone "https://github.com/PapirusDevelopmentTeam/arc-kde.git" "$CACHE_DIR/arc-kde"
fi

if [ -d "$CACHE_DIR/Breezemite" ]; then
    git -C "$CACHE_DIR/Breezemite" pull
else
    git clone "https://github.com/andreyorst/Breezemite.git" "$CACHE_DIR/Breezemite"
fi
echo "==== Syncing Files ===="

rsync -r --include="decoration.svg" --exclude "*.svg" --exclude "metadata.desktop" --exclude "AUTHORS" "$CACHE_DIR/arc-kde/aurorae/themes/Arc/" "$ARC_DIR"
rsync -r --include="decoration.svg" --exclude "*.svg" --exclude "metadata.desktop" --exclude "AUTHORS" "$CACHE_DIR/arc-kde/aurorae/themes/Arc-Dark/" "$ARC_DARK_DIR"

rsync -r --include="*/" --exclude="decoration.svg" --include="*.svg" --exclude="*" "$CACHE_DIR/Breezemite/Breezemite/" "$ARC_DIR"
rsync -r --include="*/" --exclude="decoration.svg" --include="*.svg" --exclude="*" "$CACHE_DIR/Breezemite/Breezemite_dark/" "$ARC_DARK_DIR"

echo "==== Applying Fixes ===="

mv "$ARC_DIR/Arcrc" "$ARC_DIR/OSX-Arcrc"
mv "$ARC_DARK_DIR/Arc-Darkrc" "$ARC_DARK_DIR/OSX-Arc-Darkrc"


