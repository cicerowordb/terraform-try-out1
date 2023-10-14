# Terraform Try Out 1
This is a simple example to use Terraform to create AWS resources via Github Actions. The code uses an EC2 instance copies files from a S3 bucket and uses a RDS database.

### Requirements
* Access to an AWS account with rigth permissions
* Security group default whit TCP/22, TCP/80 and TCP/5000 open to internet
* Private subnet with rigth IP addresses to use
* Private key in local host

### Install Terraform
If you want to install Terraform and AWS Cli in your computer (tests ran in Debian 11) use:
```bash
cd /tmp/
apt update
apt install -y unzip wget awscli
echo Configure your AWS credencials. I like to use file ~/.aws/credentials 
wget https://releases.hashicorp.com/terraform/1.0.8/terraform_1.0.8_linux_amd64.zip
unizp terraform_1.0.8_linux_amd64.zip
mv terraform /usr/local/bin
```
Check oficial documentation to know more.

### Some AWS Usefull Commands to Troubleshoot


INSTANCE PROFILES
```bash
aws iam list-instance-profiles
aws iam remove-role-from-instance-profile --role-name EC2-IAM-Role-Cicerow --instance-profile-name EC2-Instance-Profile-Cicerow
aws iam delete-instance-profile --instance-profile-name EC2-Instance-Profile-Cicerow
```

IAM ROLE POLICY
```bash
aws iam list-role-policies --role-name EC2-IAM-Role-Cicerow 
aws iam delete-role-policy --role-name EC2-IAM-Role-Cicerow --policy-name EC2-IAM-Policy-Cicerow
```

IAM ROLES
```bash
aws iam list-roles
aws iam delete-role --role-name EC2-IAM-Role-Cicerow
```

INSTANCE
```bash
aws ec2 describe-instances
aws ec2 terminate-instances --instance-ids <INSTANCE-ID>
```

RDS
```bash
aws rds describe-db-instances
aws rds delete-db-instance --skip-final-snapshot --db-instance-identifier <DB-INSTANCE-ID>
```

INSTANCE NETWORK
```bash
aws ec2 describe-network-interfaces
aws ec2 delete-network-interface  --network-interface-id <INTERFACE-ID>
```

ELASTIC IP
```bash
aws ec2  describe-addresses
aws ec2 release-address --allocation-id <ALLOCATION-ID>
```
### Vídeos

Se você quer ver uma explicação (em português) do que está nesse repositório acesse:

Links para as outras partes:

* Parte1: https://www.youtube.com/watch?v=w9VHiifER_8
* Parte2: https://www.youtube.com/watch?v=idwZzWiqI3Q
* Parte3: https://www.youtube.com/watch?v=jDcJGsqZvzk
* Parte4: https://www.youtube.com/watch?v=V2FYuf0bDek
* Parte5: https://www.youtube.com/watch?v=pgp5K4ylPjU
* Parte6: https://www.youtube.com/watch?v=LnnIAtspKyE
* Parte7: https://www.youtube.com/watch?v=FDXcU7PUojY
