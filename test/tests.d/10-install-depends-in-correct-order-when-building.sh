#!/bin/sh -e

kiss new A 1
kiss new B 1
kiss new C 1
echo "A" >> B/depends
echo "C" >> B/depends
kiss b B
kiss i B
# Simulate update
sed -i "s/1/2/" ./*/version
# Verify upgraded A is installed before B
echo "kiss list A | grep -q 2" >> B/build
echo "kiss list C | grep -q 2" >> B/build
kiss b A B C
kiss list A | grep 2
kiss list B | grep 2
kiss list C | grep 2
