
# Overview
This job spins up a `t4g.medium` server with Amazon Linux 2 and configures it to run a minecraft server as a Systemd unit. You will need the following to run this:

1. Terraform installed and configured, if you are on mac run
```bash
brew install terraform
export AWS_ACCESS_KEY_ID=(your aws access key id)
export AWS_SECRET_ACCESS_KEY=(your aws secret key)
```

2. An AWS account with an IAM user with the AmazonEC2FullAccess permission (or atleast permission to create an ec2 instance and security groups), you will also need a keypair configured (defaults to minecraft but you can just change the default var)

**Note:** Spinning up cloud resources will cost you $$, so be mindful of destroying the instance when you are done.

## Getting Started
Perform the following steps to spin up the server:
1. Open the directory with this README in it via command line, update the vars in variables.tf to configure the server to your liking.
2. Run `terraform apply`
3. The IP Address for your server will be printed at the end of the job:
```
Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:

server_ip = "ip address"
```
4. The server will be live now and available over port 25565, use the outputted ip address to connect from your minecraft client.


## Maintaining the Server
1. To start the server login via ssh and run `sudo systemctl start mc-server`
2. To stop the server login via ssh and run `sudo systemctl stop mc-server`
3. The server is located in `/opt/mc-server`, the service runs under a user/group called `minecraft`


## Destroying the server
When you are finished you should consider making a backup of your world, when you are ready to destroy the server run
`terraform destroy` from this directory and Terraform will clean up the resources.

## Note
This Terraform uploads the bootstrap-script to the server and executes it to create the server. Ideally this would be done by a more appropriate tool (however, this is nice in this pattern so everything is in the one spot).