svc-url() {
	namespace=$1
	serviceName=$2

	echo $(kubectl get svc -n "$namespace $serviceName" -ojsonpath='{.spec.clusterIP}')
}

wup() {
	url=$(svc-url system seaweedfs-master)
	weed upload -master="$url:9333"
}
