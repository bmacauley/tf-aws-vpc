#-----------------------------------------
# outputs.tf
#-----------------------------------------



output "nat_instance_id" {
  description = "nat instance id"
  value       = aws_instance.nat_instance.id
}
