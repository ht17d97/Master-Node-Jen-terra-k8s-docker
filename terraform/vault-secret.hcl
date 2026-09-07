listner "tcp" {
    address = "127.0.0.1:8200"
    tls_disable = true
}
storage "raft" {
    path = "/vault/data"
    node_id = "node1"
}
disable_mlock = true
api_addr = "http://localhost:8200"
cluster_addr = "http://localhost:8200"
ui = true
