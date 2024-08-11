output "instance_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.my_public_instance.public_ip
}

output "s3_bucket_url" {
  description = "The URL of the S3 bucket hosting"
  value       = aws_s3_bucket.my_bucket.website_endpoint
}