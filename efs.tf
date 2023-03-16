# resource "aws_efs_file_system" "efs" {
#     creation_token = "efs"
#     performance_mode = "generalPurpose"
#     throughput_mode = "bursting"
#     tags = {
#         Name = "EFS"
#     }
# }

# resource "aws_security_group" "efs" {
#     name = "efs-sg"
#     description= "Allows inbound efs traffic"
#     vpc_id = module.vpc.vpc_id

#     ingress {
#         from_port = 2049
#         to_port = 2049 
#         protocol = "tcp"
#         cidr_blocks = [module.vpc.vpc_cidr_block]
#     }     
        
#     egress {
#         from_port = 0
#         to_port = 0
#         protocol = "-1"
#         cidr_blocks      = ["0.0.0.0/0"]
#         ipv6_cidr_blocks = ["::/0"]
#     }
# }
# resource "aws_efs_mount_target" "efs-mt" {
#    count = length(module.vpc.private_subnets)
#    file_system_id  = aws_efs_file_system.efs.id
#    subnet_id = module.vpc.private_subnets[count.index]
#    security_groups = [aws_security_group.efs.id]
#  }