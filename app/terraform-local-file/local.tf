resource "local_file" "rapid" {
    filename = "/home/rapidadmin/new/projectbase/terraform-local-file/team.txt"
    content = "We love DevOps!"
    file_permission = "0700"
}
