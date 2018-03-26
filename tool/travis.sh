#!/bin/bash

# Fast fail the script on failures.
set -e

# Check arguments.
TASK=$1

if [ -z "$PKG" ]; then
  echo -e '\033[31mPKG argument must be set!\033[0m'
  echo -e '\033[31mExample: tool/travis.sh angular analyzer\033[0m'
  exit 1
fi

if [ -z "$TASK" ]; then
  echo -e '\033[31mTASK argument must be set!\033[0m'
  echo -e '\033[31mExample: tool/travis.sh angular analyzer\033[0m'
  exit 1
fi

# Navigate to the correct sub-directory, and run "pub upgrade".
pushd $PKG

case $TASK in

presubmit)
    pub upgrade
    dartanalyzer --fatal-warnings .
    dart tool/grind.dart
    dartfmt lib/ --line-length=120 --set-exit-if-changed -n
    dartfmt test/ --line-length=120 --set-exit-if-changed -n
    ;;

testing)
    dartium --version
    pub run test -p vm
    pub run angular_test --test-arg=-pdartium --test-arg=--timeout=4x --test-arg=--exclude-tags=flaky-on-travis
    pub run test -pdartium --tags "!(aot)"
    ;;

  *)
   echo -e "\033[31mNot expecting TASK '${TASK}'. Error!\033[0m"
   exit 1
   ;;
esac