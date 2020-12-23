### Install Ansible
The Ansible software is installed on the client side and manages the "Managed Nodes" or "Hosts". For installing it, execute the following

```
sudo su
apt update
apt install ansible
```

### Configure the global inventory
The inventory is the list of managed servers by Ansible. They can be grouped with an alias or treated individually.
The file is on /etc/ansible/hosts however you can use individual inventory files for the Playbooks.

### Execute a Playbook
```
ansible-playbook -l [group] [playbook yaml file]
ansible-playbook -i [inventory] [playbook yaml file]
```