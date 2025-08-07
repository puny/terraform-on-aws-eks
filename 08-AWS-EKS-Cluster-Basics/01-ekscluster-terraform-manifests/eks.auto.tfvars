cluster_name = "eksdemo1"
cluster_service_ipv4_cidr = "172.20.0.0/16"
cluster_version = "1.33"

# SPOT, ON_DEMAND
node_capacity_type = "SPOT"
node_instance_type = "t3a.small"
cluster_endpoint_private_access = true
cluster_endpoint_public_access = false
cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]

