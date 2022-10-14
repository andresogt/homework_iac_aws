resource "aws_instance" "EC2_SOD" {
  ami = var.ami_id
  subnet_id = var.subnet_id
  instance_type = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids = [var.sg_id]
  tags = {
      Name = "EC2_SOD"
  }
  key_name = var.key_name
  user_data = <<-EOF
                #!/bin/bash
                sudo apt update
                sudo apt install docker.io -y
                git clone https://github.com/andresogt/cicdworkshop.git
                cd cicdworkshop/
                sudo docker build -t sod .
                sudo docker run -d -p 80:80 sod
                EOF
}

