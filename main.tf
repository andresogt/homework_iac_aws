module "network" {
  source              = "./src/modules/network"
  vpc_cidr            = var.vpc_cidr
  public_subnet1_cidr = var.public_subnet1_cidr
  public_subnet2_cidr = var.public_subnet2_cidr

}

module "ec2" {
  source = "./src/modules/ec2"
  instance_type = var.instance_type
  key_name = var.key_name
  ami_id = var.ami_id
  sg_id = module.network.sg_id
  subnet_id = module.network.subnet_id_ec2
}