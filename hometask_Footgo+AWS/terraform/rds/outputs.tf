# Subnets
output "rds_db" {
  description = "List of IDs of private subnets"
  value       = aws_db_instance.dbfootgo
}
