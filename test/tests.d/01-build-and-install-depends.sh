#!/bin/sh -e

kiss new foo 1
kiss new bar 1
echo foo > bar/depends
kiss b bar
kiss list
kiss list foo
