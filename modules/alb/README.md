## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| certificate\_arn | The certificate arn for listener of loadbalancer. | `string` | n/a | yes |
| environment | The name of the environment to use for the tag. | `string` | n/a | yes |
| name | The name of the loadbalancer and to use for base name of related resources. | `string` | n/a | yes |
| public\_subnet\_ids | List of public subnet ids to place the loadbalancer in. | `list(string)` | n/a | yes |
| service\_name | The name of your service. It's used for name of the s3 bucket. | `string` | n/a | yes |
| vpc\_id | The vpc id for loadbalancer. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| dns\_name | The dns name of created loadbalancer. |
| id | The id of created loadbalancer. |
| zone\_id | The zone id of created loadbalancer. |

