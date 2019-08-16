.PHONY: server client claen

require-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "Environment variable $* not set"; \
		exit 1; \
	fi

server: require-K8S_NODE
	cat k8s-iperf.yaml | sed -s "s/{NODE}/$(K8S_NODE)/g" | kubectl apply -f -

client: require-K8S_NODE
	@if [[ "$$(kubectl get pod -l app=iperf-server 2> /dev/null)" == "" ]]; then \
		>&2 echo "No server run."; exit 1;\
	fi
	@POD=$$(kubectl get pod -o wide -l app=iperf-client | grep $(K8S_NODE) | awk '{print $$1}'); kubectl exec $${POD} -- iperf -c iperf-server

clean:
	@if [[ "$$(kubectl get pod -l app=iperf-server)" != "" || "$$(kubectl get pod -l app=iperf-client)" != "" ]]; then \
		kubectl delete --cascade -f k8s-iperf.yaml; \
	fi