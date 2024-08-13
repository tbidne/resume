{
  description = "My resume";
  inputs.flake-parts.url = "github:hercules-ci/flake-parts";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  outputs =
    inputs@{
      flake-parts,
      nixpkgs,
      self,
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      perSystem =
        { pkgs, ... }:
        let
          spellDeps = [
            pkgs.aspell
            pkgs.aspellDicts.en
          ];
          spellDictPath = "${pkgs.aspellDicts.en}/lib/aspell/en_AU.multi";
        in
        {
          packages.default = pkgs.stdenv.mkDerivation {
            name = "tbidne-resume";
            src = ./.;
            buildInputs = [ pkgs.texlive.combined.scheme-full ];
            installPhase = ''
              cd tex
              pdflatex tbidne_resume.tex -halt-on-error
              cd ../

              mkdir -p $out
              cp tex/tbidne_resume.pdf $out
            '';
          };

          devShells.default = pkgs.mkShell {
            buildInputs = [
              pkgs.entr
              pkgs.texlive.combined.scheme-full
            ] ++ spellDeps;

            SPELL_DICT = spellDictPath;
          };

          apps =
            let
              fmtShellApp = pkgs.writeShellApplication {
                name = "format";
                runtimeInputs = [ pkgs.nixfmt-rfc-style ];
                text = "nixfmt flake.nix";
              };
              spellCheckApp = pkgs.writeShellApplication {
                name = "spellcheck";
                runtimeInputs = spellDeps;
                text = "SPELL_DICT=${spellDictPath} ./tools/spellcheck.sh";
              };
            in
            {
              format = {
                type = "app";
                program = "${fmtShellApp}/bin/${fmtShellApp.name}";
              };
              spellcheck = {
                type = "app";
                program = "${spellCheckApp}/bin/${spellCheckApp.name}";
              };
            };
        };
      systems = [
        "x86_64-darwin"
        "x86_64-linux"
      ];
    };
}
