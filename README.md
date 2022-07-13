# cloudfixLinter-demoCode

## Steps on running the demo

1. Clone the repo locally by using git clone command (ensure that you have git installed)

2. Terraform CLI installation: The terraform CLI would need to be installed to deploy resources and get back the outputs of the deployed resources. For linux based systems, run the following commands to install terraform CLI:(the actual user should already have terraform cli installed since he has been using it)
    1. sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
    2. curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    3. sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    4. sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

    Run "terraform" on the command line to verify that it is recognised as a command

3. Ensure that terraform can access your AWS account. You can either put in the access key and the secret key inside of the provider "aws" block eg: in the main.tf file

provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}

or you could export AWS_ACCESS_KEY_ID , AWS_SECRET_ACCESS_KEY , AWS_SESSION_TOKEN as enviroment variables (this approach is preffered). More information on how to give access can be found [here](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

4. Run "terraform init" to initialise terraform, and then "terraform apply" to deploy the resources.

2. Jq installation: Install Jq by running the following command: (this dependence would be removed later)

    sudo apt-get install jq


3. TfLint installation: Install tflint by running the following command:

curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

4. In your cloned directory, make a file named ".tflint.hcl". Paste the following lines in the file:

plugin "template"{
    enabled = true
    version = "0.1.4"
    source  = "github.com/trilogy-group/tflint-ruleset-template"
}

5. Run "tflint --init" to install the plugin. 

6. the "reccos.json" file needs to be updated with the resource ids of the actual deployed resources. 

    run
    terraform show -json |  jq '.values.root_module.resources[] | select(.address=="aws_ebs_volume.example") | .values.id'

    to get the id for the ebs resource. Paste this value in the fisrt object in reccos.json in the resourceID field (currently it has been set to "vol-0607b88a2e8861d07")

    run
    terraform show -json |  jq '.values.root_module.resources[] | select(.address=="aws_instance.showcase-1") | .values.id'

    to get the id for the ec2 resource. Paste this value in the second object in reccos.json in the resourceID field (currently it has been set to "i-0d979e8ce8341fe38")

7. Download the orchestrator linux binary from [this_release_page] (https://github.com/trilogy-group/cloudfix-linter/releases)

8. Run the orchestrator from the directory in which your terraform demo code is present. You should see reccomendations being flagged in your console. 

9. To test additional functionality, remove the tags from any one of the resources and run the orchestrator again.

10. You could also change the yor_trace tag to any other number that is not a yor_trace for a separate resource. When you run the orchestrator now, you should see that you are being asked to run a terraform apply to correct your error. Run "terraform apply" and then the run the orchestrator again. You should see recommendations being flagged off again. 



