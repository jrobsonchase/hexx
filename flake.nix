{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    fenix.url = "github:nix-community/fenix";
  };
  outputs = { self, nixpkgs, flake-utils, fenix, ... }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ fenix.overlays.default ];
      };
      toolchain = pkgs.fenix.complete.toolchain;
    in
    {
      devShells.default = with pkgs; mkShell {
        packages = [
          toolchain
          rust-analyzer-nightly
        ];
      };
    });
}
