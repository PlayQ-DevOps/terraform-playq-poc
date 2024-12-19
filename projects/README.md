The projects folder is for the Tofu + Harness POC. Harness "projects" are how we
manage AWS Accounts or Environments in the Harness platform.

We can add workspace provisioning for each service. This creates a workspace for
each environment <> service pair.

```
.
├── development
│   ├── service-a
│   │   ├── input.tfvars
│   │   └── workspace
│   │       └── main.tf
│   ├── service-b
│   │   ├── input.tfvars
│   │   └── workspace
│   │       └── main.tf
│   └── service-c
│       ├── input.tfvars
│       └── workspace
│           └── main.tf
└── devopssandbox
    ├── service-a
    │   ├── input.tfvars
    │   └── workspace
    │       └── main.tf
    ├── service-b
    │   ├── input.tfvars
    │   └── workspace
    │       └── main.tf
    └── service-c
        ├── input.tfvars
        └── workspace
            └── main.tf
```

We can then add multi region AND workspace provisioning for each serivce by
using the following folder structure. This creates a workspace for every region
<> environement <> service trio.

```
.
├── us-east-1
│   ├── development
│   │   ├── service-a
│   │   │   ├── input.tfvars
│   │   │   └── workspace
│   │   │       └── main.tf
│   │   └── service-b
│   │       ├── input.tfvars
│   │       └── workspace
│   │           └── main.tf
│   └── devopssandbox
│       ├── service-a
│       │   ├── input.tfvars
│       │   └── workspace
│       │       └── main.tf
│       └── service-b
│           ├── input.tfvars
│           └── workspace
│               └── main.tf
└── us-west-1
│   ├── development
│   │   ├── service-a
│   │   │   ├── input.tfvars
│   │   │   └── workspace
│   │   │       └── main.tf
│   │   └── service-b
│   │       ├── input.tfvars
│   │       └── workspace
│   │           └── main.tf
│   └── devopssandbox
│       ├── service-a
│       │   ├── input.tfvars
│       │   └── workspace
│       │       └── main.tf
│       └── service-b
│           ├── input.tfvars
│           └── workspace
│               └── main.tf

```
