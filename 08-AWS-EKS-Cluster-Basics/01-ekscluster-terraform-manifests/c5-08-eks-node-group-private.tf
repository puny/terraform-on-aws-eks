# Create AWS EKS Node Group - Private

resource "aws_launch_template" "eks_ng_lt" {
  name_prefix   = "${aws_eks_cluster.eks_cluster.name}-nodegroup-"
  # image_id      = data.aws_ami.amzlinux2.id
  instance_type = var.node_instance_type
  key_name      = "new-ec2-key"

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 20
      volume_type = "gp3"
      delete_on_termination = true
    }
  }

  network_interfaces {
    # public subnet nodegroup에서 eip 만들지 않는 설정 launch template 에서 설정 가능
    # 이거를 false로 하면 외부 통신이 되지 않아 nodegroup join되지 않는 문제 발생 !!
    associate_public_ip_address = false
  }
}

resource "aws_eks_node_group" "eks_ng_private" {
  cluster_name    = aws_eks_cluster.eks_cluster.name

  node_group_name = "${local.name}-eks-ng-private"
  node_role_arn   = aws_iam_role.eks_nodegroup_role.arn
  subnet_ids      = module.vpc.private_subnets
  #version = var.cluster_version #(Optional: Defaults to EKS Cluster Kubernetes version)    
  
  ami_type = "AL2023_x86_64_STANDARD"  
  capacity_type = var.node_capacity_type
  # disk_size = 20
  # instance_types = [ var.node_instance_type ]
  
  
  # remote_access {
  #   ec2_ssh_key = "eks-terraform-key"    
  # }

  launch_template {
    id      = aws_launch_template.eks_ng_lt.id
    version = "$Latest"
  }

  scaling_config {
    desired_size = 1
    min_size     = 1    
    max_size     = 2
  }

  # Desired max percentage of unavailable worker nodes during node group update.
  update_config {
    max_unavailable = 1    
    #max_unavailable_percentage = 50    # ANY ONE TO USE
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-AmazonEC2ContainerRegistryReadOnly,
  ]  
  tags = {
    Name = "Private-Node-Group"
    cost = "Private-Node-Group"
  }
}

