<h1>Read this note in order to understand the project</h1>

I’ve built a two-tier architecture, a classic and deliberate pattern:
Private subnet 1 (10.0.10.0/24) → completely isolated, no outbound internet. Ideal for backend services like databases.
Private subnet 2 (10.0.20.0/24) → has outbound access through NAT (for app servers needing updates, patches, or API calls).
Public subnets (10.0.1.0 + 10.0.2.0) → open to IGW, for ALBs, bastion hosts, NATs, etc.
That’s a good security design. wE’re segmenting intentionally.


The next step is implementing Aplication Load Balancer