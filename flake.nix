{
  description = "Description for the project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    devshell.url = "github:numtide/devshell";

  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devshell.flakeModule
      ];
      systems = [ "x86_64-linux" ];
      perSystem = { config, self', inputs', pkgs, system, ... }:
        {
          devshells = {
            go = {
              packages = [
                pkgs.bashInteractive
                pkgs.go
                pkgs.gofumpt
                pkgs.golangci-lint
                pkgs.gomodifytags
                pkgs.protoc-gen-go-grpc
                pkgs.gotests
                pkgs.gotestsum
                pkgs.gotools
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

                pkgs.xorg.libX11.dev
              ];

            };
            typescript = {
              packages = [

                pkgs.bashInteractive
                pkgs.nodejs_22
                pkgs.yarn
                pkgs.nodePackages.ts-node
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
                (pkgs.python312.withPackages (ps: [ ps.psycopg2  ps.pandas]))
              ];
            };

          };
        };
    };
}
