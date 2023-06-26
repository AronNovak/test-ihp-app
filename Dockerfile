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
    echo "nixpkgs=https://github.com/NixOS/nixpkgs/archive/51bcdc4cdaac48535dabf0ad4642a66774c609ed.tar.gz" >> ~/.nix-defexpr/channels/nixpkgs

# Use Cachix
RUN cachix use digitallyinduced && \
    cachix use devenv

# Install devenv.sh
RUN nix profile install github:cachix/devenv/latest

RUN apt install direnv -y

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

