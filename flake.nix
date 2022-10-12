{

  description = "terraform-k8s-cillium-starter";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable"; 
    flake-utils.url  = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };

    in with pkgs; {
      devShell = mkShell {
        buildInputs = [
          cloud-utils
          packer
          cdrkit
          cfssl
          jq
          openssl
          terraform
          terraform-providers.libvirt
          kubectl
          kubernetes-helm-wrapped
          cilium-cli
          hubble
        ];
      };
    }
  );
}
