#!/bin/sh -e

kiss new foo 1
kiss new bar 1
kiss new baz 1

echo 'foo make' > bar/depends
echo 'bar make' > baz/depends
kiss b baz
kiss i baz
kiss list foo bar baz
kiss r foo bar baz
kiss list foo && exit 1
kiss list bar && exit 1
kiss list baz && exit 1
exit 0
