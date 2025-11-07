#!/bin/bash

aws ec2 describe-key-pairs | jq -r .KeyPairs[].KeyName

