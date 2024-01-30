{
	inputs = {
		nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
		nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
		lanzaboote.url = "github:nix-community/lanzaboote";
	};

	outputs = args: with args; {
		nixosConfigurations.radiant = nixpkgs-stable.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = args;
			modules = [ ./configuration.nix lanzaboote.nixosModules.lanzaboote ];
		};
	}; 
}
