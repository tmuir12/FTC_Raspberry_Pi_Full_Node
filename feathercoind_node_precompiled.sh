echo This script transforms your raspbian installation to a working feathercoin client.
echo Feathercoind will be installed in /usr/local/bin/
echo The blockchain, chainstate and conf files will be installed in /home/pi/.feathercoin
echo press enter to continue, or ctrl c to quit...
read whatever

cd /home/pi

echo
echo updating software...
echo
sudo apt-get -y update
sudo apt-get -y upgrade
echo
echo installing ufw firewall...
echo

sudo apt-get -y install ufw

echo disabling ipv6 in ufw...
cd /home/pi
sudo cat /etc/default/ufw > ufw
sed -i '/IPV6=/d' ufw
echo "IPV6=no" >> ufw
sudo mv -f ufw /etc/default/ufw
sudo chmod 644 /etc/default/ufw
sudo chown root:root /etc/default/ufw 

echo configuring ufw...
echo Opening up Port 22 TCP for SSH
sudo ufw allow 22/tcp
echo opening up Port 9336 for Feathercoin
sudo ufw allow 9336/tcp
sudo ufw status verbose
sudo ufw --force enable

echo
echo installing dependencies for feathercoin...
echo
sudo apt-get -y install build-essential libboost-dev libboost-system-dev libboost-filesystem-dev libboost-program-options-dev libboost-thread-dev libssl-dev libdb++-dev libminiupnpc-dev git g++ g++-4.6
echo

echo
echo Downloading feathercoind and installing in /usr/local/bin
########################################################
#Comment out this section if you do not want to download my compiled
#feathercoind and save yourself 4 hours compiling
cd /usr/local/bin
sudo wget https://www.dropbox.com/s/ysnlchtvk9er4wl/feathercoind
sudo chmod 755 feathercoind
#######################################################

cd /home/pi
mkdir .feathercoin

#############################################################
#If you comment out the section above uncomment this section to download the source and compile yourself
#cd /home/pi
#echo
#echo downloading source files...
#echo
#sudo git clone https://github.com/FeatherCoin/Feathercoin.git
#cd Feathercoin/src
#echo
#echo compiling... this takes about 4 hours...
#echo
#sudo make -f makefile.unix USE_UPNP= feathercoind
#sudo cp -f /home/pi/Feathercoin/src/feathercoind /usr/local/bin
#
#echo
#echo Removing source files...
#echo
#sudo rm -rf /home/pi/Feathercoin
##############################################################



echo
echo Setting up feathercoind conf file
echo
echo "# feathercoin.conf" > .feathercoin/feathercoin.conf
echo "# JSON-RPC options for controlling a running feathercoind process" >> .feathercoin/feathercoin.conf
echo "# Server mode allows featehrcoind to accept JSON-RPC commands" >> .feathercoin/feathercoin.conf
echo "# You must set rpcuser and rpcpassword to secure the JSON-RPC api" >> .feathercoin/feathercoin.conf
echo "rpcuser=rpcuser" >> .feathercoin/feathercoin.conf

echo Enter a long random password for rpc. This should NOT be your wallet password.
echo You wont need this password for normal use, so make it long and difficult.
echo You can change it anytime by restarting this configuration script.
read rpcpassword

echo "rpcpassword=$rpcpassword" >> .feathercoin/feathercoin.conf
echo "listen=1" >> ~/.feathercoin/feathercoin.conf
echo "server=1" >> ~/.feathercoin/feathercoin.conf
echo "maxconnections=100" >> ~/.feathercoin/feathercoin.conf

echo moving start script for feathercoind to /etc/init.d
sudo mv /home/pi/FTC_Raspberry_Pi_Full_Node/feathercoin /etc/init.d
cd /etc/init.d
sudo chmod 755 feathercoin
sudo chmod 755 feathercoin

sudo update-rc.d feathercoin defaults

cd /home/pi/.feathercoin

echo Downloading blockchain and chainstate. This is a 570 Meg download so will take some time
echo press enter to continue, or ctrl c to quit...
read whatever

sudo wget https://www.dropbox.com/s/tkm5ca09zvmod4n/blockchain.zip
unzip blockchain.zip
sudo rm blockchain.zip

echo thats you all set up just sudo reboot to restart your pi, give it a few minutes after booting for the featehrcoind daemon to start up and your off and running






