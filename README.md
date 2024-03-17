# challenge

Required Files:
- Ansible:
  - install.yaml : This is the ansible playbook. 
  - inventory.txt : This is the list of hosts the playbook is using. Also contains uninstall Tokens.
  
- PowerShell: 
  - powershell.ps1 : Primary PowerShell file.  
  - inventory.txt : This is the list of hosts the PS1 script runs against. Also contains uninstall Tokens. 


Assumptions:
  - PowerShell:
    - Remote assets are configured for winrm, and the deployment server has proper access to the servers.
    - CrowdStrike requires a unique Token, or Maintenance Token, to uninstall. Tokens for each host have already been identified and saved in the ps_inventory.txt file.
    - Only works on Windows Systems.
    
  - Ansible:
    - Designed to deploy to multiple systems. Current script is configured to manage CentOS 7, CentOS 8 and Ubuntu 14+.
    - SentinelOne requires a unique Token, or Passphrase, to uninstall. Tokens for each host have already been identified and saved in the inventory.ini file.
