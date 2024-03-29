## Migrating Terraform State to Terraform Cloud ##

In this lab, you will migrate your local Terraform state to Terraform Cloud for better collaboration between you and your trusty team. You will create and configure a Terraform Cloud workspace, where you will store your state for your EC2 instance remotely. Then, you will add a backend configuration to your Terraform configuration file and apply the updated configuration.


# Set Up the Environment #
Set Up and Apply Your Terraform Configuration
View the contents of the directory:

ls
Change to the lab-migrate-state directory:

cd lab-migrate-state/
In the ../ subdirectory, open the resource_ids.txt file:

`vim ../resource_ids.txt`
Copy both the ami and subnet_id values for later use in the lab.

Exit the file by pressing ESC and entering :q!.

Open the main.tf file for editing:

`vim main.tf`
Press I to enter Insert mode. In the ami line, delete the DUMMY_VALUE_AMI_ID value and, inside of the quotes, paste the AMI you copied from the resource_ids.txt file.

In the subnet_id line, delete the DUMMY_VALUE_SUBNET_ID value and, inside of the quotes, paste in the subnet ID copied from the resource_ids.txt file.

Save and exit the file by pressing ESC and entering :wq.

Initialize the working directory:

terraform init
Apply the configuration:

terraform apply
When prompted, type yes. Press Enter to confirm.

# Generate Your Access Key in the AWS Management Console #

Navigate to the AWS Management Console in a browser window, and log in with the credentials provided.


Use the search bar at the top of the page to navigate to the IAM dashboard.


On the IAM dashboard, under Access management, click Users.

In the list of users, click cloud_user.

Click the Security credentials tab.

Click the Create access key button.

Select Third-party service and click the check box under the warning. Then, click Next.

Click Create access key.

At the bottom, click Download .csv file.
Note: You may also choose to copy and paste the Access key ID and Secret access key values directly from this window.

# Set Up Your Terraform Cloud Workspace #
Create the Workspace and Configure Your Environment Variables

In a new browser tab, navigate to https://app.terraform.io/session.

Click Free account, and follow the prompts to create a new free account, or click Sign in to log in with an existing account.

Once you've confirmed your email and you are logged in, select the Start from scratch setup workflow option.

In the Organization name field, enter ACG-Terraform-Labs, and append the name with a unique number string. Copy the full name for later use.

In the Email address field, enter your email address.

Click Create organization.

Select the CLI-driven workflow option.

In the Workspace Name field, enter labs-migrate-state.

Click Create workspace.

Click the Variables tab.
Scroll down to the Workspace variables section, and click the + Add variable button.

Under Select variable category, select the Environment variable radio button.
In the Key field, type AWS_ACCESS_KEY_ID.

In the Value field, copy and paste the Access key ID value from the Create access key pop-up in the AWS Management Console or from the CSV file you downloaded.

Select the Sensitive checkbox, and click Save variable.

Click the + Add variable button.

Under Select variable category, select the Environment variable radio button.

In the Key field, type AWS_SECRET_ACCESS_KEY.

In the Value field, copy and paste the Secret access key value from the Create access key pop-up in the AWS Management Console or from the CSV file you downloaded.

Select the Sensitive checkbox, and click Save variable.

Create Your API Token for Terraform CLI Login

In the top-right corner of the Terraform Cloud window, click your user avatar and select User settings.

In the menu on the left, click Tokens.

Click Create an API token.

In the Description field, type terraform_login.

Click Create API token.

Copy the API token that is displayed in the Create API token pop-up, and click Done.

Note: Be sure that you have copied the API token, as it will not be displayed again. You may want to paste it in an accessible location, just in case.

At the top-left of the Terraform Cloud window, click the Choose an organization drop-down and select the organization you created earlier.

In the list of workspaces, click lab-migrate-state.

Add the Backend Configuration
Back in the terminal, log in to Terraform Cloud from the CLI:

terraform login
When prompted, type yes. Press Enter to proceed.

When prompted, paste in the API token you created in the previous objective, and press Enter.

Change to the /home/cloud_user/lab-migrate-state directory:

cd /home/cloud_user/lab-migrate-state
Open the main.tf file for editing:

vim main.tf
Press i to enter INSERT mode, and press Enter to add a new line at the top of the file.

Paste the following code block at the top of the file to add the remote backend to the configuration. Make sure to put in your unique organization name:

`terraform {`
  `cloud {`
    `organization = "<ORG_NAME>"`
   `workspaces {`
      `name = "labs-migrate-state"`
    `}`
  `}`
`}`
Save and exit the file:

ESC
:wq!
Check that the configuration file has been formatted properly:

terraform fmt
Initialize the working directory:

terraform init -ignore-remote-version
When prompted to copy the existing Terraform state to the new backend, type yes. Press Enter to proceed.

Verify that the terraform.tfstate.backup file has been added to the directory:

ls
Delete the terraform.tfstate file:

rm -rf terraform.tfstate
Apply the Updated Configuration and Confirm the State Was Saved to Terraform Cloud
Apply the updated configuration:

terraform apply
Once the terraform apply has finished, navigate back to Terraform Cloud in the browser.

On the Overview tab for the workspace, verify that the last run appears as a new event in the Latest Run section, and that 1 resource was applied under Resources.

Click on the States tab, and verify that the state file appears. You can click on the file to view it.

Click on the Runs tab, and view the latest runs that have completed.

To view more information about the run, click on the Overview tab, and click the See details button for the run.




