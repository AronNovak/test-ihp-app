#!/bin/sh -l

# Start the project in the background.
nix-shell /app/default.nix --run "devenv up &"

# Execute the tests.
nix-shell /app/default.nix --run "runghc $(make -C /app print-ghc-extensions) -i. -ibuild -iConfig Test/Main.hs"
