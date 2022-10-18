{

  description = "terraform-k8s-cillium-starter";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable"; 
    flake-utils.url  = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };

      cloud-init-build-img = pkgs.writeShellScriptBin "cloud-init-build-img" ''
        mkdir -p $PWD/tmp
        rm -rf ./tmp/cloud-init.img
        sed -i "s|SSH_KEY|$(cat ~/.ssh/id_rsa.pub)|g" cloud-init/packer.yml
        cloud-localds ./tmp/cloud-init.img cloud-init/packer.yml 
        sed -i "s|$(cat ~/.ssh/id_rsa.pub)|SSH_KEY|g" cloud-init/packer.yml
      '';

    in with pkgs; {
      devShell = mkShell {
        
        shellHook = ''
          alias tf-kvm="terraform -chdir=./stands/kvm"
        '';

        buildInputs = [
          cloud-utils
          cloud-init-build-img
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
