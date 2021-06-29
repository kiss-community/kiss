#!/bin/sh -e

if [ ! -x ../kiss ] || [ ! -d ../contrib ]; then
    echo "Run from tests/"
    exit 2
fi
count=0
passedCount=0
FAILED_TESTS=
DIR=$(mktemp -d)
trap 'rm -r "$DIR"' EXIT
trap "" TERM

KISS_TEST_DIR="$DIR/test"
KISS_ERROR_LOG="$DIR/test.log"
export KISS_ROOT="$DIR/root"
export KISS_PATH="$KISS_TEST_DIR"
export KISS_PROMPT=0
export KISS_TMPDIR="$DIR/temp"
export XDG_CACHE_HOME="$DIR/cache"
export PATH="$PWD/..:$PWD/../contrib:$PATH"

for script in "$PWD/tests.d/"*.sh; do
    name="$(basename "$script")"
    [ -n "$KISS_TEST" ] && [ "$KISS_TEST" != "$name" ] && continue
    mkdir -p "$KISS_TEST_DIR" "$KISS_ROOT/var/db/kiss/installed"
    count=$((count+1))
    printf "Running %s..." "$name"
    if (cd "$KISS_TEST_DIR"; sh "$script") >"$KISS_ERROR_LOG" 2>&1; then
        passedCount=$((passedCount+1))
        printf "passed\n"
    else
        printf "failed\n"
        FAILED_TESTS="$FAILED_TESTS;$name"
        cat "$KISS_ERROR_LOG" 1>&2
    fi
    rm -r "${DIR:?}"/*
done
printf "Passed %d/%d tests\n" "$passedCount" "$count"

if [ -n "$FAILED_TESTS" ]; then
    printf "Failed tests:"
    echo "$FAILED_TESTS" | sed "s/;/\n\t/g"
fi
[ "$passedCount" -eq "$count" ]
