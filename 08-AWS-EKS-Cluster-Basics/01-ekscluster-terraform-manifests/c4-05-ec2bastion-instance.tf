# AWS EC2 Instance Terraform Module
# Bastion Host - EC2 Instance that will be created in VPC Public Subnet

/*
module "ec2_public" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  #version = "5.0.0"  
  version = "6.0.2"       
  # insert the required variables here
  name                   = "${local.name}-BastionHost"
  ami                    = data.aws_ami.amzlinux2.id
  # ami                    = data.aws_ami.amzlinux2023.id
  # create_spot_instance   = true
  
  # spot_type 
  # persistent: 장기적으로 실행되는 상태 저장(stateful) 워크로드에 적합
  # one-time: 인스턴스가 종료되거나 중단되면 요청이 자동으로 취소됩니다. 인스턴스가 중단되더라도 다시 시작되지 않습니다
  # spot_type              = "one-time"
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  
  #monitoring             = true
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.public_bastion_sg.security_group_id]
  tags = local.common_tags
}
*/