{
  description = "Description for the project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    devshell.url = "github:numtide/devshell";

    flake-parts.url = "github:hercules-ci/flake-parts";

  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devshell.flakeModule
      ];
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      perSystem =
        { config
        , self'
        , inputs'
        , pkgs
        , system
        , ...
        }:
        {
          devshells = {
            go = {
              packages = [
                pkgs.bashInteractive
                pkgs.go_1_25
                pkgs.gofumpt
                pkgs.golangci-lint
                pkgs.pkg-config
                pkgs.cacert
                pkgs.gomodifytags
                pkgs.protoc-gen-go-grpc
                pkgs.gotests
                pkgs.gotestsum
                pkgs.protoc-gen-go
                pkgs.iferr
                pkgs.impl
                pkgs.mockgen
                pkgs.reftools
                pkgs.richgo
                pkgs.buf
                pkgs.delve
                pkgs.golines
                pkgs.gotest
                pkgs.gopls
                pkgs.nilaway
                pkgs.govulncheck
                pkgs.air
              ]
              ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
                # pkgs.darwin.apple_sdk.frameworks.SystemConfiguration
                # pkgs.darwin.apple_sdk.frameworks.CoreFoundation
                # pkgs.darwin.apple_sdk.frameworks.Security
              ]
              ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
                pkgs.xorg.libX11.dev
              ];
            };
            typescript = {
              packages = [

                pkgs.bashInteractive
                pkgs.nodejs_24
                pkgs.yarn
                pkgs.pnpm_9
                # pkgs.nodePackages.typescript
              ];
            };
            kubernetes = {
              packages = [

                pkgs.kubernetes
                pkgs.minikube
                pkgs.kind
              ];
            };

            python = {
              packages = [
                (pkgs.python312.withPackages (ps: [
                  ps.psycopg2
                  ps.pandas
                  ps.requests
                ]))
              ];
            };

          };
        };
    };
}
