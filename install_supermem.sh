#!/bin/bash
# This is a helper script to assist with installation of the dependencies of CrowdStrike's SuperMem (https://github.com/CrowdStrike/SuperMem) 
# Written by J Marasinghe
# Tested with Ubuntu 20.04.3 LTS

add-apt-repository ppa:gift/stable -y
apt-get update
apt-get install git python3 python2 python3-pip yara unzip zip plaso-tools -y

#Setting up Volatility 2
cd /opt/
wget http://downloads.volatilityfoundation.org/releases/2.6/volatility_2.6_lin64_standalone.zip
unzip volatility_2.6_lin64_standalone.zip
cd volatility_2.6_lin64_standalone
mv volatility_2.6_lin64_standalone vol.py
cp vol.py /usr/bin/

#Setting up Volatility 3
cd /opt/
git clone --recursive https://github.com/volatilityfoundation/volatility3.git
cd volatility3/
pip3 install -r requirements.txt
python3 setup.py build
python3 setup.py install
mv vol.py vol3
cp vol3 /usr/bin/


#Download Volatility plugins
cd /opt/ 
git clone --recursive https://github.com/volatilityfoundation/community.git

#Installing evtxtract
pip install evtxtract

#Installing Bulk_extractor
cd /opt/
git clone --recursive https://github.com/simsong/bulk_extractor.git
echo -ne '\n' | bash bulk_extractor/etc/CONFIGURE_UBUNTU20LTS.bash
cd bulk_extractor/
./configure
make
make install

#Downloading YARA rules 
cd /opt/
git clone --recursive https://github.com/Yara-Rules/rules.git

#Setting up SuperMem
git clone https://github.com/blueteam0ps/SuperMem.git
cd SuperMem
pip3 install -r requirements.txt
