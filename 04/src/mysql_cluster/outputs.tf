
output "cluster_id" {
    description = "Cluster ID"
    value = yandex_mdb_mysql_cluster.this.id
}

output "cluster_name" {
  description = "Cluster name"
  value = yandex_mdb_mysql_cluster.this.name
}