{
  description = ''A Jester web plugin that embeds key information into a JSON object.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-jesterjson-master.flake = false;
  inputs.src-jesterjson-master.owner = "JohnAD";
  inputs.src-jesterjson-master.ref   = "refs/heads/master";
  inputs.src-jesterjson-master.repo  = "jesterjson";
  inputs.src-jesterjson-master.type  = "github";
  
  inputs."jesterwithplugins".dir   = "nimpkgs/j/jesterwithplugins";
  inputs."jesterwithplugins".owner = "riinr";
  inputs."jesterwithplugins".ref   = "flake-pinning";
  inputs."jesterwithplugins".repo  = "flake-nimble";
  inputs."jesterwithplugins".type  = "github";
  inputs."jesterwithplugins".inputs.nixpkgs.follows = "nixpkgs";
  inputs."jesterwithplugins".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-jesterjson-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-jesterjson-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}