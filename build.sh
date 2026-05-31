#!/usr/bin/env bash
set -eo pipefail
shopt -s lastpipe

realpath "${BASH_SOURCE[0]}" \
    | xargs dirname \
    | read -r SCRIPTDIR

find "$SCRIPTDIR/src" -name '*.typ' | while read -r TYPFILE; do
    NAME="${TYPFILE##*/}"
    NAME="${NAME%.typ}"
    typst compile "$TYPFILE" "$PWD/$NAME.pdf"
    typst compile --features html --format html "$TYPFILE" "$PWD/$NAME.html"
done
