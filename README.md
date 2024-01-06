# Node Monitoring with Ansible

* Install [Ansible](https://docs.ansible.com/ansible/latest/getting_started/index.html)
  ```bash
  brew install ansible
  ```

* Install [VMWare Fusion](https://www.vmware.com/products/fusion.html)
  You can download VMWare Fusion free Edition for learning purpose. You need to register your account to get the License

* Install [Vagrant](https://formulae.brew.sh/cask/vagrant)
  ```bash
  brew install --cask vagrant
  vagrant --version
  ```
  Install VMWare Utility
  ```bash
  brew install vagrant-vmware-utility
  ```
  You need to setup vagrant plugin [vmware](https://developer.hashicorp.com/vagrant/docs/providers/vmware/installation)
  ```bash
  vagrant plugin install vagrant-vmware-desktop
  vagrant plugin list
  ```

## Create Key
```bash
ssh-keygen -f ./vagrant/key/vagrant-key
```

## Setup the node server
For this example we used vagrant and use plugin `vmware-desktop` since we setup the node in `Apple Mac M1`
```bash
# Up the node server
vagrant up

# See the status of the server
vagrant status

# SSH to the node server
vagrant ssh app-1
vagrant ssh app-2
vagrant prometheus
vagrant grafana
vagrant grafana-loki

ssh-add ./vagrant/key/vagrant-key
ssh vagrant@192.168.56.2
ssh vagrant@192.168.56.3
ssh vagrant@192.168.56.4
ssh vagrant@192.168.56.5
ssh vagrant@192.168.56.6

# remove all node 
vagrant destroy
```