terraform {
  backend "s3" {
    bucket         = "terraform-eks-cicd-namkj0428"
    key            = "terraform-on-aws-eks/06/vpc/my-project.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    # use_lockfile = "terraform-lock-table"
  }
}