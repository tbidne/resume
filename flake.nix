{
  description = "My resume";
  inputs.flake-parts.url = "github:hercules-ci/flake-parts";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  outputs =
    inputs@{ flake-parts
    , nixpkgs
    , self
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      perSystem = { pkgs, ... }:
        {
          packages.default = pkgs.stdenv.mkDerivation {
            name = "tbidne-resume";
            src = ./.;
            buildInputs = [ pkgs.texlive.combined.scheme-full ];
            installPhase = ''
              ${pkgs.texlive.combined.scheme-full}/bin/pdflatex $src/tbidne_resume.tex -halt-on-error
              mkdir -p $out
              cp tbidne_resume.pdf $out
            '';
          };

          devShells.default = pkgs.mkShell {
            buildInputs = [
              pkgs.texlive.combined.scheme-full
            ];
          };
        };
      systems = [
        "x86_64-darwin"
        "x86_64-linux"
      ];
    };
}
