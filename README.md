## Requirements

| Name | Version |
|------|---------|
| terraform | 0.13.2 |
| aws | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_account\_id | The aws account id. | `string` | n/a | yes |
| aws\_profile | The profile you want to use. | `string` | `"default"` | no |
| environment | The environment name for network. This is used for all resources tags.Name. | `string` | n/a | yes |
| example\_api\_domain | The domain for example api. | `string` | n/a | yes |
| main\_domain | The domain for your service. | `string` | n/a | yes |
| private\_subnets | List of arguments for subnet for public subnets. | <pre>map(object({<br>    cidr = string<br>    az   = string<br>  }))</pre> | n/a | yes |
| public\_subnets | List of arguments for subnet for public subnets. | <pre>map(object({<br>    cidr = string<br>    az   = string<br>  }))</pre> | n/a | yes |
| service\_name | The name of your service. It's used for some resource names. | `string` | n/a | yes |
| vpc\_cidr | The cidr for vpc. | `string` | n/a | yes |

## Outputs

No output.

