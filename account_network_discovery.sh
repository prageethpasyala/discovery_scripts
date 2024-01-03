#!/bin/bash
echo $'\n'
echo $'\n'
echo "Describe TGWs"
echo "-------------------------"
aws ec2 describe-transit-gateways --region $1
echo "TGW-Attachments:"
aws ec2 describe-transit-gateway-attachments --region $1
echo "TGW-RouteTables:"
aws ec2 describe-transit-gateway-route-tables --region $1
echo $'\n\n'
echo "VPCe's"
echo "----------------------------"
aws ec2 describe-vpc-endpoints --region $1
echo $'\n\n'
echo "IGWs"
echo "----------------------------"
aws ec2 describe-internet-gateways --region $1
echo $'\n\n'
echo "NAT-GWs"
echo "----------------------------"
aws ec2 describe-nat-gateways --region $1
echo "Describe VPCs"
echo "----------------------------"
aws ec2 describe-vpcs --region $1
echo $'\n'
echo "Subnets"
echo "----------------------------"
aws ec2 describe-subnets --region $1 | jq -r '[.Subnets[] | {AvailabilityZoneId, CidrBlock, SubnetId, VpcId}]' 
echo $'\n'
echo "----------------------------"
echo "NACLs:"
aws ec2 describe-network-acls --region $1
echo "VPC-RTs:" 
aws ec2 describe-route-tables --region $1 | jq -r '[.RouteTables[] | {RouteTableId, VpcId, Routes}]'
echo "SGs: "
aws ec2 describe-security-groups --region $1
echo "SG Rules: "
aws ec2 describe-security-group-rules --region $1
echo $'\n'
echo "VPC Peering"
echo "----------------------------"
aws ec2 describe-vpc-peering-connections --region $1
echo $'\n\n'
echo "Traffic Mirroring"
echo "----------------------------"
aws ec2 describe-traffic-mirror-filters --region $1
echo $'\n\n'
echo "VPC Flow Logs"
echo "----------------------------"
aws ec2 describe-flow-logs --region $1
echo $'\n\n'
echo "Addresses Description"
echo "----------------------------"
aws ec2 describe-addresses --region $1
