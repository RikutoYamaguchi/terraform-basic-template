## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cidr\_blocks | The cidr blocks for security group ingress. | `list(string)` | n/a | yes |
| environment | The name of the environment to use for the tag. | `string` | n/a | yes |
| name | The security group name. | `string` | n/a | yes |
| port | The port for security group ingress. | `number` | n/a | yes |
| vpc\_id | The vpc id for security group. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| security\_group\_id | Created security group id |

