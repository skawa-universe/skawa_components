#!/bin/bash

# Fast fail the script on failures.
set -ev

xvfb-run -s "-screen 0 1024x768x24" pub run angular_test --test-arg=-pdartium

dart tool/grind.dart