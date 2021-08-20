These Terraform templates creates 2 VPCs, one in Virginia and another in Ohio
Virginia VPC has 2 subnets: 1a and 1b 
Ohio VPC has 1 subnet: 1a 
######################################################################################
VPC peering was configured from the 2 VPCs 
There are routes from Virginia 1a subnet to Ohio 1a
There are routes from Ohio 1a subnet to Virginia 1a
There aren't any kind of routing from Virginia 1b to Ohio 1a or vice versa
######################################################################################
There is an EC2 instance in Virginia 1a
It allows SSH from internet and all outbound traffic
######################################################################################
There is an EC2 instance in Virginia 1b
It allows all traffic from Virginia 1a and all outbound traffic
######################################################################################
There is an EC2 instance in Ohio 1a
It allows all inbound and outbound traffic 
######################################################################################
The objective from this lab is to show that you can ping and ssh from Virginia 1a 
instance to Ohio 1a trought their internal IP address , but you can't repeat this 
action from Virginia 1b, even if Ohio instance accepts all inbound traffic
It's because there aren't routes from subnets in Virginia 1b to Ohio 1a
If you add these routes, you will access Ohio 1a instance from Virginia 1b subnet 
######################################################################################
Enjoy! 
nuvym.com
