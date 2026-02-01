{lib, ...}: let
  setUnfreeWarning = {
    maybeAttrs,
    prefix,
  }: let
    withoutWarning =
      if builtins.isAttrs maybeAttrs
      then
        builtins.mapAttrs
        (name: value:
          setUnfreeWarning {
            maybeAttrs = value;
            prefix = "${prefix}.${name}";
          })
        maybeAttrs
      else maybeAttrs;
    withWarning =
      if lib.isDerivation withoutWarning
      then builtins.warn "$Accessing unfree package: ${prefix}" withoutWarning
      else withoutWarning;
  in
    withWarning;
in {
  perSystem = {pkgs, ...}: {
    _module.args = {
      unfreePkgs = setUnfreeWarning {
        maybeAttrs = pkgs;
        prefix = "pkgs";
      };
    };
  };
}
