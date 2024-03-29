{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name = "pet-projects-infra-env";
  buildInputs =
    with pkgs; [
      kube3d
      kubectl
      kubectx
      k9s
      jq
      jiq
      kubernetes-helm
      (pkgs.google-cloud-sdk.withExtraComponents [
        (if pkgs.system == "aarch64-darwin"
        then pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin-darwin-arm
        else pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin)
      ])
      argocd
      yq-go
      kubeseal
      scrub
    ];
}

