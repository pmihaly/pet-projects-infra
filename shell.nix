{pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "personal-infra-env";
  buildInputs =
  let
    gke-auth-plugin =
      if pkgs.system == "aarch64-darwin"
      then pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin-darwin-arm
      else pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin;
    google-cloud = pkgs.google-cloud-sdk.withExtraComponents [ gke-auth-plugin ];
  in
    with pkgs; [
      kube3d
      kubectl
      kubectx
      k9s
      jq
      jiq
      kubernetes-helm
      google-cloud
      argocd
      yq-go
      kubeseal
      scrub
    ];
}

