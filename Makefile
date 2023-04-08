apply:
	kubectl kustomize --enable-helm overlays/main | kubectl apply -f -

kubeconfig:
	USE_GKE_GCLOUD_AUTH_PLUGIN=True gcloud container clusters get-credentials pet-projects-cluster --zone europe-central2-a

gcp-secret:
	kubectl create secret generic gcp-secret --namespace crossplane-system --from-file gcp-credentials.json

# due to kubeseal breaking down when trying to seal a multi-document yaml file,
# multiple secrets need to be processed individually, then merged together again
seal-secrets:
	kubectl kustomize overlays/main/secret-generator | yq -s '.metadata.name + ".secret-sealing.yaml"' --no-doc
	for f in *.secret-sealing.yaml; do kubeseal --format yaml <$$f > "$$(echo $$f | sed 's/secret-sealing/sealed-secret/')"; done
	scrub -r *.secret-sealing.yaml
	yq *.sealed-secret.yaml > overlays/main/secrets.sealed-secret.yaml
