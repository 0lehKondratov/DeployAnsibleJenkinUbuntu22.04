# Deploy Ansible Jenkin to Ubuntu 22.04 LTS
Deploy Jenkin to Ubuntu 22.04.1 LTS

### Add deploy terraform to Proxmox 7.1. VM Ubuntu 22.04

## 1. Ważne zmiany
   
  ~~Wyłącz tryb uśpienia systemu (Domyślnie włączony podczas standardowej instalacji systemu Ubuntu 22.04)~~
   
  ~~sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target~~
 
  ~~systemctl status sleep.target~~
   
  ~~b. Zmienne środowiskowe dla wszystkich tajnych parametrów (nazwy użytkowników, hasła)~~
  
  c. Sprawdź działanie, jeśli zainstalowane są starsze wersje
  
  e. Sprawdź pracę, aby zobaczyć, czy są skonfigurowane alternatywne repozytoria i klucze do nich (stare błędne itp.) i jak go automatycznie wyeliminować

## 2. Kroki poprawy
  
  a. Automatyczne łączenie agentów
  
  b. Instalowanie pełnej listy  plugins (tych, które są domyślnie)
  
  c. Lista wszystkiego, co należy zainstalować ta wersje -> vars/plugins.yaml, app.yaml etc
  
  d. Automatyczne tworzenie i kolejkowanie zadań
  
  e. Połączenie z klastrem

## 3. Strategiczne zadanie rozwoju na 1.x)))

  a. Przepisz kod za pomocą roli: [Ansible Role: Jenkins CI](https://galaxy.ansible.com/geerlingguy/jenkins/)
  
  b. Automatyczne tworzenie agentów w kontenerach dla określonego zadania
  
  с. Automatyczne tworzenie pod-ow dla określonego zadania

  ### Plugins: [git](https://updates.jenkins.io/download/plugins/git/latest/git.hpi)  [git ver 4.14.13](https://updates.jenkins.io/download/plugins/git/4.14.3/git.hpi)

Usage
You can run the CLI manually in Dockerfile:

Installing Custom Plugins
Installing prebuilt, custom plugins can be accomplished by copying the plugin HPI file into /usr/share/jenkins/ref/plugins/ within the Dockerfile:
```
COPY --chown=jenkins:jenkins path/to/custom.hpi /usr/share/jenkins/ref/plugins/

FROM jenkins/jenkins:lts-jdk11
RUN jenkins-plugin-cli --plugins pipeline-model-definition github-branch-source:1.8
Furthermore it is possible to pass a file that contains this set of plugins (with or without line breaks).
```

```
FROM jenkins/jenkins:lts-jdk11
COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
```


[#Jenkins Configuration as Code (a.k.a. JCasC) Plugin](https://plugins.jenkins.io/configuration-as-code/)


[Ansible Role: Jenkins CI](https://github.com/geerlingguy/ansible-role-jenkins)
<<<<<<< HEAD

ansible-galaxy install geerlingguy.jenkins
=======
ansible-galaxy install geerlingguy.jenkins


* https://www.linkedin.com/pulse/automating-jenkins-binary-installation-mohamed-mostafa/

##Terraform - Proxmox Virtual Machine Deploy
``
pveum role add TerraformProv -privs "VM.Allocate VM.Clone VM.Config.CDROM VM.Config.CPU VM.Config.Cloudinit VM.Config.Disk \
VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Monitor VM.Audit VM.PowerMgmt Datastore.AllocateSpace Datastore.Audit VM.Console"
pveum user add terraform-prov@pve --password Takietam-1
pveum aclmod / -user terraform-prov@pve -role TerraformProv
pveum user token add terraform-prov@pve terraform-token --privsep=0
```
>>>>>>> d4b8cc9 (disable sleep)
