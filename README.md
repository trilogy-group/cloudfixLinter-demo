# cloudfixLinter-demoCode

The organization currently does not have a terraform code template for which cloudfix has reccomendations. Hence, to test out [cloudfix-linter](https://github.com/trilogy-group/cloudfix-linter), this demo repo with sample terraform code has been made.

## Steps on running the demo

### Prelimnaries

1. Create resources. This template will create 6 resources -- 2 EBS volums, 2 EC2 instances, 1 S3 bucket, and 1 EFS file system.
To create them, first terraform will need to be provided creds to your AWS account. If using a personal account, this can be done by exporting AWS_ACCESS_KEY and AWS_SECRET_KEY as environment variables. If using federated login (as trilogy does), saml2aws can be used instead. For more details on how to authorize terraform can be found [here](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

2. After authorizing terraform, run

```
terraform apply
```

to create the resources

3. Since we cannot use actual reccomendations for cloudfix for the resources that we have just created, we will be reading mock reccomendations from a file to mimic the behavior. In order to tell the linter that it needs to read reccomendations from a file rather than from cloudfix itself, on the terminal run

```
export CLOUDFIX_FILE=true
```

This will make the linter read reccomendations from a reccos.json file present in the working directory. A reccos.json file has been provided with the demoCode.

4. Modify the reccos.json file with the resourceIDs for the created resources. As the resources would be created, besides them you'll find their ids. For example, when an EBS file will finish with its creation, an [id=vol-...] sort of message would be given. These ids need to be copy and pasted into the reccos.json file. There would be six ids in total.

The two ids prefixed by (vol-) need to be pasted on line #7 and #30 in the reccos.json file. The two ids prefixed by (id-) need to be pasted on line #53 and #79. The id prefixed by (fs-) needs to be pasted on line #128 and finally the id for the s3 bucket (my-tf-bucket-cloudfixlinter) needs to be pasted on line #105.

**Note**: The above steps only need to performed since we currently do not have a terraform template that has reccomendations from cloudfix. In case the template in question does have recomendations, the user would only need to export CLOUDFIX_USERNAME and CLOUDFIX_PASSWORD as environement variables rather than performing the above steps. The linter would automatically get the reccomendations from Cloudfix using their credentials.


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
cloudfix-linter recco --json
```

to get reccomendations in json format. 

4. For help, run

```
cloudfix-linter
```


 



