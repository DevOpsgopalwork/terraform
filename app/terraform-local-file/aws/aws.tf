resource "aws_instance" "webserver" {
ami = "ami-0edab43b6fa892279"
instance_type = "t2.micro"
}
# resource "aws_s3_bucket" "finance" {
# bucket = "finanace-21092020"
# tags = {
# Description = "Finance and Payroll"
# }
# }
# resource "aws_iam_user" "admin-user" {
# name = "lucy"
# tags = {
# Description = "Team Leader"
# }
# }