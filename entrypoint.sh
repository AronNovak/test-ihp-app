#!/bin/sh -l

INIT_SCRIPT="$1"

# Start the project in the background.
nix-shell /app/default.nix --run "devenv up &"

if [ -f "$INIT_SCRIPT" ]; then
  # Execute the test script.
  $INIT_SCRIPT
fi

nix-shell /app/default.nix --run "runghc $(make -C /app print-ghc-extensions) -i. -ibuild -iConfig Test/Main.hs"
