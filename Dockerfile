# Use a base image that has Nix pre-installed
FROM nixos/nix:latest

# Update the package repository sources and install necessary tools
RUN nix-channel --update && \
    nix-env -iA nixpkgs.git nixpkgs.cachix

# Set up the Nix path
RUN nix-env -iA nixpkgs.curl && \
    nix-env -iA nixpkgs.unzip && \
    nix-env -iA nixpkgs.gnumake && \
    nix-env -iA nixpkgs.bash && \
    mkdir -p ~/.nix-defexpr/channels/nixpkgs && \
    echo "nixpkgs=https://github.com/NixOS/nixpkgs/archive/51bcdc4cdaac48535dabf0ad4642a66774c609ed.tar.gz" >> ~/.nix-defexpr/channels/nixpkgs/nixpkgs

# Use Cachix
RUN cachix use digitallyinduced && \
    cachix use devenv

# Install devenv.sh
RUN echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf

RUN nix profile remove /nix/store/mh1c3p23xby3chc3q0c0g78fa1nn65yw-bash-5.2-p15
RUN nix profile install github:cachix/devenv/latest

RUN nix-shell -p direnv --run "direnv hook bash > ~/.bashrc"

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

