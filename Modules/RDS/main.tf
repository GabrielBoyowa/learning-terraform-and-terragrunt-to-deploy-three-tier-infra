


















# resource "aws_db_instance" "default" {
#   allocated_storage    = 10
#   db_name              = "mydb"
#   engine               = "mysql"
#   engine_version       = "8.0.27"
#   storage_type        = "gp3"
#   instance_class       = "db.t3.micro"
#   username             = "foo"
#   password             = "foobarbaz"
#   parameter_group_name = "default.mysql8.0"
#   publicly_accessible = true
#   skip_final_snapshot  = true

#   tags = merge(
#     # 1. The map of common tags from your variable
#     var.resource_tags,

#     # 2. Your specific, hardcoded, or dynamic tags
#     {
#       Name = "${var.project_name}-vibranium-rds"
#     }
#   )
# }






