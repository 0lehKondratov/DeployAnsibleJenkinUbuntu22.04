apt -y remove cloud-init
apt -y purge cloud-init
rm -fr /etc/cloud/
apt -y install cloud-init