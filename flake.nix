{
  description = "user configuration for stary";

  inputs = {
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs: let
    system = "x86_64-linux";
  in {
    homeConfigurations.default = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      extraSpecialArgs = { inherit inputs; };
      modules = [ ({ ... }: {
        home.homeDirectory = "/home/stary";
        home.username = "stary";
        home.stateVersion = "22.11";

        programs.home-manager.enable = true;
        programs.git.enable = true;
        programs.htop.enable = true;
        programs.tmux.enable = true;
      }) ];
    };
  };
}
