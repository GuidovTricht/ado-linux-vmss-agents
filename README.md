# How to create a Linux VMSS to run Azure DevOps Build Agents

1. Create a VMSS resource
```pwsh
az vmss create --name vmss-ado-build-agent-linux-ubuntu24 --resource-group devops --image Ubuntu2404 --vm-sku Standard_D2ads_v7 --storage-sku Standard_LRS --authentication-type SSH --generate-ssh-keys --instance-count 1 --disable-overprovision --upgrade-policy-mode manual --single-placement-group false --platform-fault-domain-count 1 --load-balancer '""' --orchestration-mode Uniform --os-disk-size-gb 64
```

2. Add the Custom Script Extension to a scale set 
```pwsh
az vmss extension set \ --resource-group myResourceGroup \ --vmss-name myScaleSet \ --name CustomScript \ --publisher Microsoft.Azure.Extensions \ --version 2.1 \ --settings '{
    "fileUris": ["https://raw.githubusercontent.com/GuidovTricht/ado-linux-vmss-agents/refs/heads/main/setup.sh"],
    "commandToExecute": "./setup.sh"
  }'
```