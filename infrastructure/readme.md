# Infrastructure project
Run this to deploy the sample app in an ECS cluster using an EC2 worker with Load Balancer.

## How to run

- Go to the infrastructure project `cd infrastructure`.
- Update `my-profile reference in `providers.tf`
- Update domain references in `acm.tf` and `dns.tf`.

### Init terraform
```
tf init
```

### Check the plan
```
tf plan --var-file=default.tfvars
```

### Apply the changes
```
tf apply -auto-approve --var-file=default.tfvars
```

### Destoy the changes
```
tf destroy --var-file=default.tfvars --auto-approve
```