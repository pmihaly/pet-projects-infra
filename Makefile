apply:
	kubectl kustomize --enable-helm overlays/main | kubectl apply -f -

kubeconfig:
	USE_GKE_GCLOUD_AUTH_PLUGIN=True gcloud container clusters get-credentials pet-projects-cluster --zone europe-central2-a

gcp-secret:
	kubectl create secret generic gcp-secret --namespace crossplane-system --from-file gcp-credentials.json
