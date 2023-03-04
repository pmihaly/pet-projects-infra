{pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "personal-infra-env";
  buildInputs =
    with pkgs; [
      kube3d
      kubectl
      k9s
      jq
      jiq
      kubernetes-helm
      awscli2
    ];
}
