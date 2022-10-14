#Network Module

region               = "us-east-1"
vpc_cidr             = "172.33.0.0/16"
public_subnet1_cidr  = "172.33.0.0/20"
public_subnet2_cidr  = "172.33.16.0/20"


#EC2 Module
instance_type = "t2.micro"
key_name = "key-SOD"
ami_id = "ami-08c40ec9ead489470"