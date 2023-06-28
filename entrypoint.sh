#!/bin/sh -l

TEST_SCRIPT="$1"

# Start the project in the background.
nix-shell /app/default.nix --run "devenv up &"

if [ -f "$TEST_SCRIPT" ]; then
  # Execute the test script.
  $TEST_SCRIPT
  exit 0
else
  # Execute the tests.
  nix-shell /app/default.nix --run "runghc $(make -C /app print-ghc-extensions) -i. -ibuild -iConfig Test/Main.hs"
fi
