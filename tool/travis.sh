#!/bin/bash

# Fast fail the script on failures.
set -ev

xvfb-run -s "-screen 0 1024x768x24" pub run angular_test --test-arg=-pdartium
xvfb-run -s "-screen 0 1024x768x24" pub run test test/base_grid_test.dart -pdartium

dart tool/grind.dart skawa_components
