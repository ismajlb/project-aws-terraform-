<h1>Two-tier application architecture built with Terraform on AWS for scalable and secure infrastructureh1>

I’ve built a two-tier architecture, a classic and deliberate pattern:
Private subnet 1 (10.0.10.0/24) → completely isolated, no outbound internet. Ideal for backend services like databases.
Private subnet 2 (10.0.20.0/24) → has outbound access through NAT (for app servers needing updates, patches, or API calls).
Public subnets (10.0.1.0 + 10.0.2.0) → open to IGW, for ALBs, bastion hosts, NATs, etc.
That’s a good security design. wE’re segmenting intentionally.


Done:

VPC Setup with subnet tiers (public & private), route tables, and NAT gateway.
S3 moved out of VPC:
    Access is controlled via an S3 VPC Gateway Endpoint (planned for private network traffic).
    IAM policies prepared for controlled access (no direct EC2 write to S3 without role or policy).



🚀 Next Steps

1.Application Load Balancer (ALB)
Distribute traffic across auto-scaled EC2 instances in public subnets.
Target groups and health checks included.

2.Database Tier
Deploy a Multi-AZ PostgreSQL RDS instance in Private Subnet 1.
Automated backups, CloudWatch monitoring, and DB parameter settings.
(Optional) Evaluate switching to DynamoDB based on workload.

3. Monitoring and Alerting
CloudWatch dashboard and alarms
SNS notifications for critical events

4. Caching
Add ElastiCache (Redis/Memcached) for read-heavy applications.

5. AWS Certificate Manager 
    We will impement Certificate Manager in order to have anything cetified