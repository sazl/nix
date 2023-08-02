{
  description = "Deploy GNU hello to localhost";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    deploy-rs.url = "github:serokell/deploy-rs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, deploy-rs, home-manager }: {
    nixosConfigurations.racknerd-nixos-system = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./common.nix ];
    };
    
    deploy.nodes.sami-nixos = {
      sshOpts = [ "-p" "22" ];
      hostname = "racknerd";
      fastConnection = true;
      remoteBuild = true;

      profiles = {
        system = {
          sshUser = "root";
          path =
            deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.racknerd-nixos-system;
          user = "root";
        };
      };
    };

    checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
  };
}
