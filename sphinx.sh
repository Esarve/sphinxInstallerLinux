#!/bin/bash
echo "creating directory"
mkdir ~/Sphinx
cd ~/Sphinx
echo "Installing Dependencies"
echo "Choose your Distribution"
echo "1. Debian (ubuntu / mint / pop....)"
echo "2. Arch / Manjaro"
read ans
if [[ $ans -eq '1' ]]
then
    sudo apt-get update && sudo apt-get install gcc automake autoconf libtool bison swig python-dev libpulse-dev

elif [[ $ans -eq '2' ]]
then
    sudo pacman -S gcc automake autoconf libtool bison swig python-dev libpulse-dev

else
    exit 1 
fi
echo -e "\e[92mCloning git for sphinxbase\e[0m"
git clone https://github.com/cmusphinx/sphinxbase.git
cd sphinxbase/
./autogen.sh
make
sudo make install
cd ..
echo "\n-------------------D O N E-------------------\n"
echo -e "\e[92mInstalling Pocket Sphinx\e[0m"
git clone https://github.com/cmusphinx/pocketsphinx.git
cd pocketsphinx
./autogen.sh
make
sudo make install
cd ..
echo "\n-------------------D O N E-------------------\n"
echo -e "\e[92mInstalling SphinxTrain\e[0m"
git clone https://github.com/cmusphinx/sphinxtrain.git
cd sphinxtrain
./autogen.sh
make
sudo make install
cd ..
echo "\n-------------------D O N E-------------------\n"
echo "Installing Sub version"
sudo apt-get install subversion
echo "Enabling Sub Version"
echo "Installing CMULMTK"
svn checkout svn://svn.code.sf.net/p/cmusphinx/code/trunk/cmuclmtk
cd cmusphinx-code/
./autogen.sh
make
sudo make install
cd ..
echo "\n-------------------D O N E-------------------\n"
echo -e "\e[92mInstallation Finished\e[0m"
echo "Clearing in"
echo "3"
sleep 1
echo "2"
sleep 1
echo "1"
clear
echo -e "\e[92mConfiguring ld.so.conf\e[0m"
echo "Backing UP ld.so.conf"
sudo cp /etc/ld.so.conf /etc/ld.co.conf.bak
echo "Backed up as ld.co.conf.bak"
echo 'include /etc/ld.so.conf.d/*.conf\n/usr/local/lib' > ld.so.conf
sudo mv ld.so.conf /etc/
sudo ldconfig
echo -e "\e[92mConfigured\e[0m"




