# Repository
Run this to create a ECR repository to deploy the sample app.

# How to run

- Update `my-profile reference in `providers.tf`

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