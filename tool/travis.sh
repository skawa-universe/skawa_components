#!/bin/bash

# Fast fail the script on failures.
set -ev

dartfmt lib/ --line-length=120 --set-exit-if-changed -n
dartfmt test/ --line-length=120 --set-exit-if-changed -n
dartium --version
pub run test -p vm

pub run angular_test --test-arg=-pdartium --test-arg=--timeout=4x
pub run test test/base_grid_test.dart -pdartium

dart tool/grind.dart