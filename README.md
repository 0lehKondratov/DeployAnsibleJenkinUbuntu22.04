# Deploy Ansible Jenkin to Ubuntu 22.04 LTS
Deploy Jenkin to Ubuntu 22.04.1 LTS


https://updates.jenkins.io/download/plugins/git/latest/git.hpi
https://updates.jenkins.io/download/plugins/git/4.14.3/git.hpi

Usage
You can run the CLI manually in Dockerfile:

Installing Custom Plugins
Installing prebuilt, custom plugins can be accomplished by copying the plugin HPI file into /usr/share/jenkins/ref/plugins/ within the Dockerfile:

COPY --chown=jenkins:jenkins path/to/custom.hpi /usr/share/jenkins/ref/plugins/

```
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
ansible-galaxy install geerlingguy.jenkins