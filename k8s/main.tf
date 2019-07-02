provider "kubernetes" {}


resource "kubernetes_deployment" "db-deployment" {
    metadata {
        name = "mongo"
    }

    spec {
        replicas = 1

        selector {
            match_labels {
                name = "mongo"
            }
        }

        template {
            metadata {
                labels {
                    name = "mongo"
                }
            }

            spec {
                container {
                    image = "mongo"
                    name = "mongo"
                    port {
                        container_port = 27017
                    }
                }
            }
        }
    }
}

resource "kubernetes_deployment" "api-deployment" {
    metadata {
        name = "api-deployment"
    }

    spec {
        replicas = 2

        selector {
            match_labels {
                component = "api"
            }
        }

        template {
            metadata {
                labels = {
                    component = "api"
                }
            }

            spec {
                container {
                    image = "coppertreetestregistry.azurecr.io/cta:latest"
                    name = "books-api"
                    port {
                        container_port = 5000
                    }
                }
            }
        }
    }
}

resource "kubernetes_service" "api-cluster-ip-service" {
    metadata {
        name = "api-cluster-ip-service"
    }

    spec {
        selector {
            component = "api"
        }

        port {
            port = 5000
            target_port = 5000
        }
    }
}


resource "kubernetes_service" "db-cluster-ip-service" {
    metadata {
        name = "mongo-cluster-ip-service"
    }

    spec {
        selector {
            name = "mongo"
        }

        port {
            port = 27017
            target_port = 27017
        }
    }
}

resource "kubernetes_ingress" "books-ingress-service" {
    metadata {
        name = "books-ingress-service"
    }

    spec {
        backend {
            service_name = "api-cluster-ip-service"
            service_port = 5000
        }
    }
}