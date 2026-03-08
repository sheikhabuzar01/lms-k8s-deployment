## Follow the Commands Mention in the Lab File 

## Error After `terraform apply`

After running `terraform apply`, you may see the following error:

```bash
module.eks.module.eks_managed_node_group["worker_nodes"].aws_eks_node_group.this[0]: Creating...
module.eks.module.eks_managed_node_group["worker_nodes"].aws_eks_node_group.this[0]: Still creating... [00m10s elapsed]

Warning: Argument is deprecated

Error: waiting for EKS Node Group create: unexpected state 'CREATE_FAILED', wanted target 'ACTIVE'.

Ec2SubnetInvalidConfiguration: One or more Amazon EC2 Subnets
[subnet-0dc44180bd7bbb38c, subnet-0d0f794c19c0a6fe6]
does not automatically assign public IP addresses to instances launched into it.

```

## Run the following commands to enable Auto Assign Public IP on your subnets:

```bash
aws ec2 modify-subnet-attribute --subnet-id <your-subnet-id> --map-public-ip-on-launch --region us-east-1
```
```bash
aws ec2 modify-subnet-attribute --subnet-id <your-subnet-id> --map-public-ip-on-launch --region us-east-1
```
