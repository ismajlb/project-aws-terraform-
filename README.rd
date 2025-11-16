<h1>Read this note in order to understand the project</h1>

I’ve built a two-tier architecture, a classic and deliberate pattern:
Private subnet 1 (10.0.10.0/24) → completely isolated, no outbound internet. Ideal for backend services like databases.
Private subnet 2 (10.0.20.0/24) → has outbound access through NAT (for app servers needing updates, patches, or API calls).
Public subnets (10.0.1.0 + 10.0.2.0) → open to IGW, for ALBs, bastion hosts, NATs, etc.
That’s a good security design. wE’re segmenting intentionally.


The next steps will be:
1. Implementing Aplication Load Balancer
2. Moving S3 out of of the region and creating an Gateway Endpoint. -> S3 has been moved to another region. Gateway Endpoint will be implemented.
3. DB will be implemented on Subnet Private 1. Uilt a multi-AZ RDS PostgreSQL architecture. 
    Automated creation of DB parameters, monitoring with CloudWatch, and implemented automated backups with retention policies.

in the end will be implemented Monitoring and Alerts