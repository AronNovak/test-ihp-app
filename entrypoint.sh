#!/bin/sh -l

# Start the project in the background.
nix-shell --run "devenv up &"

# Execute the tests.
nix-shell --run "runghc $(make print-ghc-extensions) -i. -ibuild -iConfig Test/Main.hs"

