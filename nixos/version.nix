{ pkgs }:
let
  npinsData = builtins.fromJSON (builtins.readFile ../npins/sources.json);
  flakeData = builtins.fromJSON (builtins.readFile ../flake.lock);

  npinsHash = npinsData.pins.nixpkgs.hash;
  flakeLocked = flakeData.nodes.nixpkgs.locked;
  flakeHash = flakeLocked.narHash;

  ricochetVersion =
    assert flakeHash == npinsHash;
    if flakeLocked ? rev then flakeLocked.rev else flakeHash;
in
{
  inherit ricochetVersion;

  package = pkgs.writeShellScriptBin "ricochet-version" ''
    echo "${ricochetVersion}"
  '';
}
