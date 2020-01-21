# Tutorial: Deploy a static website using terraform on Google Cloud Platform
## Getting Started
Introduction to infrastructure as code (IaC) using Terraform on the Google Cloud Console.

This tutorial will show you how to use terraform in a terminal environment in Google cloud shell.

**Time to complete**: About 10 minutes

##

### Copy the Github repository URL
1. On this page select the "Clone or download" button ![clone-or-download-button](/media/images/github-clone-or-download-button.png) and **copy the URL**. It should start like this:

>   git clone **https://**

### Google Cloud Console

1. In a **new browser window**, follow this link [console.cloud.google.com](https://console.cloud.google.com) and sign on with your credentials. Once signed in, go to your **Google Cloud Shell** 

![google-cloud-shell](/media/images/GCP-google-cloud-shell.png)

This will open a **terminal** at the bottom of the page. Please wait for it to establish a connection. Once opened it should show: 
>     your-username@cloudshell:~ (your-project-number)$

2. Paste in the **URL** you've previously copied from **GitHub** after the `$` and **enter**.

Now you have a copy of the repository in **Google Cloud Shell**. 
    
3. In the **Cloud Shell terminal** type in:
>     cd terraform-workshop/gcp/compute-lab

This will take you to the files you need to run.

4. Next type in: 
>     ls

This will **"list"** the contents of the folder. You should see:

>`instance.tf  provider.tf  index.html  variables.tf and README.md`

If you do, excellent! 

Move on to the next stage...

### Terraform!

Terraform delivers infrastructure as code, by creating new resources, managing existing ones and destroy no longer needed resources. Read [here](https://www.terraform.io/intro/index.html) for more information about Terraform

**Google Cloud Shell** already has **Terraform** installed. So all you need to do is initialise the Terraform files. 

1. This is done by entering the following into the cloud shell terminal:
>     terraform init

 This is to intialise a working directory containing the Terraform configuration files.

2. Next enter:
>     terraform plan

**Terraform plan** is used to create an execution plan. Terraform performs a refresh, (unless disabled) and then determines what actions are necessary to achieve the desired state specified in your configuration files. This is a convenient way to check whether the execution plan for a set of changes matches your expectations without making any changes to the actual resources or to the state.
    
3. Run this command:
>     terraform apply

**terraform apply** command is used, as you've guessed it, to apply the changes. This is required to reach the desired state of the configuration.

4. Finally run:
>     yes

...to confirm you want to apply and run the Terraform.

Take a look around the **Google Console**, if you look at the **Compute Engine** section you can see there is now a **VM Instance** resource there, that wasn't there before.

5. Find the public IP address of this VM instance and  copy this and paste into a new browser tab/window.

If you were successful, you should see: “Welcome Cloudy Team Member <YOUR NAME> , your host name is <YOUR HOST NAME> - <YOUR PRIVATE IP>"

![final-static-website](/media/images/GCP-static-website-final.png)

### Now what if we would like to make changes to the website?

6. Back at the **Terminal** at the bottom, type in 
>     vi index.html

...to open index.html file with a text editor in the Terminal window.

7. Next type:
>     i

8. Now you can edit the text with:

>   `Welcome Cloudy Team Member <YOUR NAME>, your host name is $HOSTNAME - $PRIVATE_IP`

9. Press ESC and type:
>     :wq!

and Enter to exit and save. This is shorthand for "write" and "save". Don't forget the ":"


10. You can see and apply your changes using  these commands:
>     terraform plan  -out example.tfplan

>     terraform apply example.tfplan

**Success!** 

![ralph-well-done](/media/images/ralph-well-done.jpg)


**Don't forget to clean up after yourself** 

11. In the terminal enter:
>     terraform destroy

...to delete the resources. This will avoid unnecessary charges.