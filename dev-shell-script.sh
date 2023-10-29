#!/bin/bash

### Instance Template Version - 2 ######
# gunicorn issue로 인한 Instance_Templat의 Startup Script에 기입 필요  ### 
sudo apt-get update -y   
sudo apt-get install -y python3-pip python3-dev libpq-dev curl wget git software-properties-common 
sudo apt-get update -y 

pip install -U git+https://github.com/benoitc/gunicorn.git
pip3 install -U git+https://github.com/benoitc/gunicorn.git

sudo apt-get update -y 
sudo apt-get install gunicorn -y 
whereis gunicorn

pwd
cat /etc/os-release
sudo mkdir -p /home/packer/deployinstall
sudo chmod -R 777 /home/packer/deployinstall
sudo chmod -R 777 /usr/bin/gunicorn
ls -alh
cd ~/deployinstall
git clone -q https://github.com/GoogleCloudPlatform/python-docs-samples.git
cd /python-docs-samples/compute/managed-instances/demo/templates
pwd
sudo sed -i s/blue/purple/g index.html
cd ../
pwd
sudo pip3 install -r requirements.txt
nohup ./usr/bin/gunicorn --bind 0.0.0.0:80 app:app --daemon &
curl 0.0.0.0:80 

echo "###############"
echo "DONE PROCESS"
echo "###############"

##GCP OpsAgent Install & Check ### 

echo "##############################"
echo "######OpsAgent Install########"
echo "##############################"

curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
sudo bash add-google-cloud-ops-agent-repo.sh --also-install
sudo systemctl status google-cloud-ops-agent"*"

##TimeZone Setting
echo "######TimeZone Setting########"
sudo timedatectl set-timezone Asia/Seoul
kst_check=`sudo date`
echo $kst_check

