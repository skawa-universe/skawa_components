#!/bin/bash

# Fast fail the script on failures.
set -ev

#dartfmt lib/ --line-length=120 --set-exit-if-changed -n
# dartfmt test/ --line-length=120 --set-exit-if-changed -n

xvfb-run -s "-screen 0 1024x768x24" pub run angular_test --test-arg=-pdartium --test-arg=test/stabilizator_test.dart
xvfb-run -s "-screen 0 1024x768x24" pub run angular_test --test-arg=-pdartium --test-arg=test/editor_render_source_test.dart
# xvfb-run -s "-screen 0 1024x768x24" pub run test test/base_grid_test.dart -pdartium

# dart tool/grind.dart
