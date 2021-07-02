#!/bin/sh -e

kiss new kiss 1
kiss new foo 1

kiss b kiss foo
kiss i kiss foo

sed -i "s/1/2/" ./*/version

kiss u
kiss list kiss | grep 2
kiss list foo | grep 2
