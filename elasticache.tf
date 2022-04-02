resource "aws_elasticache_cluster" "example" {
  cluster_id           = "cluster-example"
  engine               = "memcached"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.4"
  port                 = 11211
}
