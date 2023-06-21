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
$env:CLOUDFIX_USERNAME="<MY_USERNAME>"
$env:CLOUDFIX_PASSWORD="<PASSWORD>"
```
- Linux and Devspaces
```
export CLOUDFIX_FILE=false
export CLOUDFIX_USERNAME="<MY_USERNAME>"
export CLOUDFIX_PASSWORD="<PASSWORD>"
```

template in question does have recomendations, the user would only need to export CLOUDFIX_USERNAME and CLOUDFIX_PASSWORD as environement variables rather than performing the above steps. The linter would automatically get the reccomendations from Cloudfix using their credentials.


### Running the Cloudfix linter CLI

1. Add the binary to `PATH` 
   1. For linux, macOS, devspaces
      ```
      export PATH=$PATH:~/.cloudfix-linter/bin
      ```
   2. For Windows
      ```
      $Env:PATH += ";${HOME}\.cloudfix-linter\bin"
      ```
Note: In the following commands replce `cloudfix-linter` with `cloudfix-linter.exe` for windows

2. Run

```
cloudfix-linter tf init

```

to init the directory in which the linter has to be run

3. Run

```
terraform apply
```

to deploy the resources


4. Run

```
cloudfix-linter tf reco
```

to get reccomendations on the console

OR Run

```
cloudfix-linter tf reco -j
```

to get reccomendations in json format. *(This command may not prompt descriptive errors currently, try without `-j` flag if having issues)*

5. For help, run

```
cloudfix-linter
```

### Running the [Cloudfix linter Extension](https://open-vsx.trilogy.devspaces.com/extension/devfactory/cloudfix-linter)

1. Install the extension from [here](https://open-vsx.trilogy.devspaces.com/extension/devfactory/cloudfix-linter)
2. Open the terraform "folder" in VSCode.
3. Get command palette by `Ctrl+Shift+P` and run command `Cloudfix-linter: Init`.
4. Select `mock-recommendations` for the demo [repo](https://github.com/trilogy-group/cloudfixLinter-demo/).
5. Ensure that terraform can access your AWS account. You can use one of the following
   1. Devconnect with [saml2aws](https://github.com/Versent/saml2aws)
   2. Set the access key and the secret key inside of the provider "aws" block eg: in the main.tf file provider "aws" { region = "us-east-1" access_key = "my-access-key" secret_key = "my-secret-key" }
   3.  Set and export AWS_ACCESS_KEY_ID , AWS_SECRET_ACCESS_KEY , AWS_SESSION_TOKEN as enviroment variables. More information on how to give access can be found [here](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
6. Run the following commands.
   ```
   terraform init
   terraform apply
   ```
7. For `mock-recommendations`, run the following commands.
   ```
   terraform show -json > tf.show
   python3 utils/gen_recco.py tf.show
   ```
8. Save the terraform file. Now the extension will start showing lintings for possible optimizations.
9. For some specific recommendations you can also use Quick fix option to modify it upon hovering on the linting.


### Getting back to inital state after completing demo

1. Redoing all the changes made till now .
This includes removing the additional files created


a. Run

```
git clean -fxd
```
this should remove all the local files created in current directory

b. Run

```
git reset --hard HEAD
```
This should revert the changes done.

c. Finally do a reload with clear cache in your IDE.
For VSCode Steps are -
  - Open command pallet `cmd+shift+P`.
  - Choose reload window with clear cache.

### Troubleshooting

1. Logs are created at `cloudfix-linter/logs` folder
2. At times because of some version upgrade things might not work, easiest way to go about it is
    - Delete cloudfix-linter folder
    - Reload vscode window
      - `ctrl+shift+p` to open command palette
      - Select `Developer: Reload Window`
    - This will reinstall the linter to reinitiate the process from scratch
