#!/bin/sh -e

kiss-new foo 1
kiss-new bar 1
kiss-new baz 1

echo 'foo make' > bar/depends
echo 'bar make' > baz/depends
kiss b baz
kiss r foo bar
# fail to build foo bar again
echo 'exit 1' >> foo/build
echo 'exit 1' >> bar/build
# clear cache
rm -r "$XDG_CACHE_HOME"
kiss b baz
