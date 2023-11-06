This is a pipeline project to deploy the following 

- one RG
- one VNet in it
- one Subnet in that vnet
- one nsg and an allow all inbound rule in it
- 3 random passwords and adding them in the keyvault as secrets
- creating a storage account to test explicit dependeny
- 3 vms with login pass as the above created ones.

And a pipeline.yml file to create a pipeline in Azure DevOps.

To Be Done
Create an SP in Azure with contributor access and pass the 4 values in access.auto.tfvars and backend.json. Add them in .gitignore and pass these 2 files as secure files in the pipeline.

