# CloudFixLinter-demoCode

The organization currently does not have a terraform code template for which CloudFix has reccomendations. Hence, to test out [Cloudfix-linter](https://github.com/trilogy-group/cloudfix-linter), this demo repo with sample terraform code has been made.

If you are using Devspaces this repo will load up a vscode extension. [This video](https://www.loom.com/share/df3dd6361fec44d29b98417c5a3cfd1f) demonstrates how to use the extension.

## Steps on running the demo

### Prelimnaries

1. This terraform template will create 19 resources:-

| Resource Type   |      Count      |
|:----------:|:-------------:|
| aws_dynamodb_table |  1 |
| aws_ebs_volume | 4 |
| aws_instance | 4 |
| aws_nat_gateway | 1 |
| aws_vpc_endpoint | 1 |
| aws_s3_bucket | 3 |
| aws_efs_file_system | 1 |
| aws_s3_bucket_acl | 1 |
| aws_s3_bucket_public_access_block | 1 |
| aws_s3_bucket_versioningterraforte | 1 |
| aws_neptune_cluster | 1 |

To create them, first terraform will need to be provided creds to your AWS account. If using a personal account, this can be done by exporting AWS_ACCESS_KEY and AWS_SECRET_KEY as environment variables. If using federated login (as trilogy does), saml2aws can be used instead. For more details on how to authorize terraform can be found [here](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

If you are using the DevFactory OIDC session tokens, then upload the credentials file to the base folder and run

```
./demo_setup.sh credentials.json
. run1.sh
```

2. After authorizing terraform, run

```
terraform apply
```

to create the resources

3. Since CloudFix waits 14 days before it makes recommendations for resources, there will be no reccomendations for the resources just created. You can either mock the recommendations, or use CloudFix.
#### To use mock recommendations.
In order to generate mock recommnedations and tell the linter that it needs to read reccomendations from a file rather than from CloudFix itself, on the terminal run
- Windows
```
$env:CLOUDFIX_FILE=$true
terraform show -json > tf.show
python utils/gen_recco.py tf.show
```
- Linux and Devspaces
```
export CLOUDFIX_FILE=true
terraform show -json > tf.show
python utils/gen_recco.py tf.show
```

#### To use cloudFix recommendations
- Windows
```
$env:CLOUDFIX_FILE=$false
$env:CLOUDFIX_USERNAME=<MY_USERNAME>
$env:CLOUDFIX_PASSWORD=<PASSWORD>
```
- Linux and Devspaces
```
export CLOUDFIX_FILE=false
export CLOUDFIX_USERNAME=<MY_USERNAME>
export CLOUDFIX_PASSWORD=<PASSWORD>
```

template in question does have recomendations, the user would only need to export CLOUDFIX_USERNAME and CLOUDFIX_PASSWORD as environement variables rather than performing the above steps. The linter would automatically get the reccomendations from Cloudfix using their credentials.


### Running the linter

1. Run 

```
cloudfix-linter init

```

to init the directory in which the linter has to be run

2. Run

```
terraform apply
```

to apply the tags added by cloudfix-linter init


3. Run

```
cloudfix-linter recco
```

to get reccomendations on the console

OR Run

```
cloudfix-linter recco -j
```

to get reccomendations in json format. 

4. For help, run

```
cloudfix-linter
```


 



