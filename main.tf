provider "aws" {
  region = "eu-west-1"
}

provider "mongodbatlas" {}


module "atlas_cluster" {
  source = "module/"

  project_name = "my-project"
  org_id       = "<org_id>"

  teams = {
    Devops : {
      users : ["mky013120@mail.io", "mky013120@yahoo.io"]
      role : "GROUP_OWNER"
    },
    DevTeam : {
      users : ["mky013120@mail.io"]
      role : "GROUP_READ_ONLY"
    }
  }

  white_lists = {
    "example comment" : "52.12.41.46/32", #Random CIDR
    "second example" : "54.215.4.201/32"
  }

  region = "EU_WEST_1"

  cluster_name = "MyCluster"

  instance_type      = "M30"
  mongodb_major_ver  = 4.2
  cluster_type       = "REPLICASET"
  num_shards         = 1
  replication_factor = 3
  provider_backup    = true
  pit_enabled        = false

  vpc_peer = {
    vpc_peer1 : {
      aws_account_id : "<aws_account_id>"
      region : "eu-west-1"
      vpc_id : "<vpc-ID>"
      route_table_cidr_block : "172.16.0.0/16"
    },
    vpc_peer2 : {
      aws_account_id : "<aws_account_id>"
      region : "eu-west-2"
      vpc_id : "<vpc-id>"
      route_table_cidr_block : "172.17.0.0/16"
    }
  }

}