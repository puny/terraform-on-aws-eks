#!/bin/bash

# aws keypair를 생성하고 파일로 저장함 이 키 파일로 접속해야 정상 동작함

aws ec2 create-key-pair --key-name eks-terraform-key --query 'KeyMaterial' --output text > eks-terraform-key.pem