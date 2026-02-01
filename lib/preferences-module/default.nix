# This module is an NixOS/home-manager module
# that specifies build preferences
# (e.g., host, performance-related flags, etc.).
{lib, ...}: {
  options.comavius.dotsV2.preferences = {
    host = lib.mkOption {
      type = lib.types.enum [
        "sagume"
        "hecatia"
      ];
    };
  };
}
