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

### Getting back to inital state after completing demo

1. Redoing all the changes made till now .
This includes removing the yor tags added to the resources and files created by various scripts


a. Run

```
git clean -fxd
```
this should remove all the local files created in current directory

b. Run

```
git reset --hard HEAD
```
This should remove all the yor tags and other changes done.

c. Finally do a reload with clear cache in your IDE.
For VSCode Steps are -
  - Open command pallet `cmd+shift+P`.
  - Choose reload window with clear cache.

###FAQ's
###### These FAQ's try to cover the questions that user might face while using Mock recommendation or Cloudfix account.

1. What will happen if the user no Tags block in the terraform scripts?  
=> If there are not tags block in terraform files extension will show a linting message about missing tag block and a solution for  how to rectify it.
<img width="761" alt="image" src="https://user-images.githubusercontent.com/110278052/216258011-596c459b-3ebe-4454-9dfd-b2120bfe0b5d.png">


 
2. What will happen if the user has yor tags before installing extension?  
=> Extension recognises the prescence of the yor tags. Even on running the apply tags command these tags won't change.


3. What if user tries to get recommendation without applying yor_traces?  
=> Extension will lint a message stating yor_trace_ids can't be found and the solution to it.
<img width="751" alt="image" src="https://user-images.githubusercontent.com/110278052/216258326-4563b505-cd48-4a33-a2b9-96b6a8f4eac9.png">

4. what will happen if user changes the Yor tags for some reason?  
=> Since yor tags are the key to recognise the resources that have been deployed by that terraform module. A linting stating traceId can't be linked to any AWS resource will be shown.
<img width="751" alt="image" src="https://user-images.githubusercontent.com/110278052/216258738-bfa8426f-0a66-4803-800b-4cc5d6b0c701.png">






