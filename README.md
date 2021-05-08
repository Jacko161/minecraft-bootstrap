This job spins up a t4g.medium server with Amazon Linux 2 and configures it to run a minecraft server as a Systemd unit. You will need the following to run this:

1 - Terraform installed and configured, if you are on mac run
        ```
        
        brew install terraform
        export AWS_ACCESS_KEY_ID=(your aws access key id)
        export AWS_SECRET_ACCESS_KEY=(your aws secret key)
        
        ```

2 - Obvious an AWS account with an IAM user with the AmazonEC2FullAccess permission (or atleast permission to create an ec2 instance and security groups), you will also need a keypair configured with the name minecraft (or just change the default var)

Perform the following steps to spin up the server:
1 - cd into this directory.
2 - Run `terraform apply`
3 - Ssh onto the server as ec2-user (run `ssh -i "/path/to/pem/file" ec2-user@ec2.ip.address`)
4 - Run `sudo ./bootstrap-server.sh` 