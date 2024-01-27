svc-url() {
	namespace=$1
	serviceName=$2

	echo $(kubectl get svc -n $namespace $serviceName -ojsonpath='{.spec.clusterIP}')
}

filer-url() {
	echo "$(svc-url system seaweedfs-filer):8888"
}

wcp() {
	url="$(svc-url system seaweedfs-filer):8888"
	weed filer.copy 
}

wup() {
	url="$(svc-url system seaweedfs-master):9333"
	weed upload -master="$url"
}
