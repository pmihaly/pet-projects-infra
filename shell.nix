{pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "personal-infra-env";
  buildInputs =
    with pkgs; [
      kube3d
      kubectl
      kubectx
      k9s
      jq
      jiq
      kubernetes-helm
      google-cloud-sdk
    ];
}
