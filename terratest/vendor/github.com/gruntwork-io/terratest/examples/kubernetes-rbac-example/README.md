# Kubernetes RBAC Example

This folder contains a Kubernetes resource config file that creates a new Namespace and a ServiceAccount that has admin
level permissions in the Namespace, but nowhere else. This example is used to demonstrate how you can test RBAC
permissions using terratest.

See the corresponding terratest code ([kubernetes_rbac_example_test.go](../../test/kubernetes_rbac_example_test.go)) for
an example of how to test this resource config:


## Deploying the Kubernetes resource

1. Setup a Kubernetes cluster. We recommend using a local version:
    - [minikube](https://github.com/kubernetes/minikube)
    - [Kubernetes on Docker For Mac](https://docs.docker.com/docker-for-mac/kubernetes/)
    - [Kubernetes on Docker For Windows](https://docs.docker.com/docker-for-windows/kubernetes/)

1. Install and setup [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) to talk to the deployed
   Kubernetes cluster.
1. Run `kubectl apply -f namespace-service-account.yml`


## Running automated tests against this Kubernetes deployment

1. Setup a Kubernetes cluster. We recommend using a local version:
    - [minikube](https://github.com/kubernetes/minikube)
    - [Kubernetes on Docker For Mac](https://docs.docker.com/docker-for-mac/kubernetes/)
    - [Kubernetes on Docker For Windows](https://docs.docker.com/docker-for-windows/kubernetes/)

1. Install and setup [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) to talk to the deployed
   Kubernetes cluster.
1. Install and setup [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/).
1. Install [Golang](https://golang.org/) and make sure this code is checked out into your `GOPATH`.
1. `cd test`
1. `dep ensure`
1. `go test -v -tags kubernetes -run TestKubernetesRBACExample`
