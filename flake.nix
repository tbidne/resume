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
              cd tex
              ${pkgs.texlive.combined.scheme-full}/bin/pdflatex tbidne_resume.tex -halt-on-error
              cd ../

              mkdir -p $out
              cp tex/tbidne_resume.pdf $out
              echo $out
            '';
          };

          devShells.default = pkgs.mkShell {
            buildInputs = [
              pkgs.entr
              pkgs.texlive.combined.scheme-full
            ];
          };

          apps =
            let
              fmtShellApp = pkgs.writeShellApplication {
                name = "format";
                runtimeInputs = [ pkgs.nixpkgs-fmt ];
                text = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt flake.nix";
              };
            in
            {
              format = {
                type = "app";
                program = "${fmtShellApp}/bin/${fmtShellApp.name}";
              };
            };
        };
      systems = [
        "x86_64-darwin"
        "x86_64-linux"
      ];
    };
}
