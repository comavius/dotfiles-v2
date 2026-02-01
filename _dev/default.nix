{inputs, ...}: {
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  perSystem = {
    pkgs,
    config,
    ...
  }: {
    treefmt = {
      projectRootFile = "flake.nix";
      programs = {
        alejandra.enable = true;
      };
    };

    devShells.default = pkgs.mkShell {
      buildInputs = [config.treefmt.build.wrapper pkgs.nil];
    };
  };
}
