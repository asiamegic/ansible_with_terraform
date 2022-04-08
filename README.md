<b>Terraform and Ansible</b><br>

The project was created with the help of Ansible and Terraform. Terraforms deployed two development workspaces and with Ansible, the software was installed and configured in an automated mode from the master server.<br>

There are two workspaces consisting of elastic computers, load balancer, database and two subnets separating them as well as NSG rules. The production area has more powerful resources than staging. From the outside of this infrastructure there is external access only to the application site on a specific port 8080 all other resources are closed.

![week-6-envs](https://user-images.githubusercontent.com/85096533/161988532-57880f23-2480-4190-a47a-2a68d867e2c1.png)

<b>This project allows you to deploy two workspaces using one source data. in order to switch between staging and production, you need to change the first four parameters in the variable file. for convenience they are commented out
</b>

![3](https://user-images.githubusercontent.com/85096533/162010630-fc2ca2a3-807f-44a2-9a3c-87952c7de5aa.jpg)


<br>
<b>Terraform modules</b><br>
In the current directory <b>./modules/vm</b> there is a virtual machine module which, if necessary, can be re-launched or excluded from the description of the main file in the main directory of each project. modules can borrow variables from the parent variable file by redirection, but this prerequisite must be described.<br><br>


<b>Ansible variables there are two files: </b>

<b>inventory.ini</b> it contains groups of hosts to which it is possible to deploy program settings in our case, as shown in the picture, there are two groups, staging and production, where we can write IP addresses or domain names of servers, there are also server login and password parameters (by default authorization must be enabled through them)

![1](https://user-images.githubusercontent.com/85096533/161988762-e5032be8-d9bc-45f0-853c-1969cb62e39a.jpg)

<b>playbook.yml </b> which contains directly variable settings of the software itself within each server. for example, the installation directory, the repository directory from where to download the necessary files, logins, database passwords, and okta authorization data.

![2](https://user-images.githubusercontent.com/85096533/161988729-1941a5f8-67fb-489f-88a1-60bc26a42ffd.jpg)

<b>Terraform modules</b>
in the current directory <b>./modules/vm</b> there is a virtual machine module which, if necessary, can be re-launched or excluded from the description of the main file in the main directory of each project. modules can borrow variables from the parent variable file by redirection, but this prerequisite must be described.


<b>Ansible Quick Start commands:</b>
<b> sudo apt update</b> - update the registry

<b> sudo apt install python3.8 </b> - preferably a fresh version of python 
<br>
<br><b>sudo apt install ansible </b> - you will also need to install ansible itself

<br><b> ansible -i inventory.ini -m ping all </b> - this command will ping the servers specified in the inventory file ansible-playbook playbook.yml -i inventory.ini is itself the most interesting part of installing the software. we specify the name of our playbook and the inverter file from which everything will be installed

<br><b> playbook.yml </b> - playbook file describing packages to be installed inventory.ini - contains the name of the hosts and you can also write authentication data

<br>To get acquainted with the terraforms, follow the links -
https://github.com/asiamegic/terraform
<br><b> Good luck! </b>
