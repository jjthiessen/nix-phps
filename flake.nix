{
  description = "Repository of Nix expressions for old PHP versions";

  inputs = {
    # Shim to make flake.nix work with stable Nix.
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Must be at least as old as 156b3dd so as to still have OpenSSL 1.0.2u
    nixpkgs-ancient.url = "github:NixOS/nixpkgs/156b3dd93a9b2e785b889a3c7be4df524688fea3";

    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-compat, nixpkgs, nixpkgs-ancient, utils }:
    # For each supported platform,
    utils.lib.eachDefaultSystem (system:
      let
        # Let’s merge the package set from Nixpkgs with our custom PHP versions.
        pkgs = import nixpkgs.outPath {
          config = {
            allowUnfree = true;
          };
          inherit system;
          overlays = [
            (final: prev: {
              inherit (nixpkgs-ancient.legacyPackages.${system}) openssl_1_0_2;
            })
            self.overlays.default
          ];
        };
      in rec {
        packages = {
          inherit (pkgs) php php53 php54 php55 php56 php70 php71 php72 php73 php74 php80 php81 php82 php83;
        };

        checks = import ./checks.nix {
          inherit packages pkgs system;
        };
      }
    ) // {
      overlays.default = import ./pkgs/phps.nix nixpkgs.outPath;
    };
}
