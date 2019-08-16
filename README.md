# k8s-iperf

Modified from [kubernetes-iperf3](https://github.com/Pharb/kubernetes-iperf3) to benchmark kubernetes cluster network performance. Will use iperf to measure network performance with multiple connections from each nodes.

## How to use

Select a node as iperf server, and all the other nodes in kubernetes cluster will try to connect to server at the same time.

```bash
./k8s-iperf <server-node>
```

## Output

```text
[Start] iperf server
deployment.apps/iperf-server-deployment created
service/iperf-server created
daemonset.apps/iperf-clients created
Waiting for iperf server to start...

[Start] iperf clients
[Run] iperf-client pod iperf-clients-fffsm
[Run] iperf-client pod iperf-clients-fxnhw
...... done

------------------------------------------------------------
Server listening on TCP port 5001
TCP window size: 85.3 KByte (default)
------------------------------------------------------------
[  4] local 10.233.66.68 port 5001 connected with 10.233.64.59 port 52912
[  5] local 10.233.66.68 port 5001 connected with 10.233.65.74 port 52236
[ ID] Interval       Transfer     Bandwidth
[  4]  0.0-10.0 sec  2.98 GBytes  2.55 Gbits/sec
[  5]  0.0-10.0 sec  2.87 GBytes  2.47 Gbits/sec

[Cleanup]
deployment.apps "iperf-server-deployment" deleted
service "iperf-server" deleted
daemonset.apps "iperf-clients" deleted
```
