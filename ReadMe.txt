Create a Feathercoin Full Node Without Compiling


This instruction is to create a Feathercoin full node on a raspberry Pi.
You will need the following things before we start
* Raspberry Pi Model B, or B+
* Minimum 8Gb class 10SD card, but I recommend a 16Gb Note: You may even get away with a 4GB card but I recommend against it
* Monitor, keyboard and mouse to plug into the Pi for Initial setup (Not needed after setup is complete
* You need to read up on your router and find out how to make it statically assign an IP address to the Raspberry Pi and how to set up port forwarding on it for both inbound and outbound traffic on port 9336
* You need to be able to SSH from your main computer to the PI to check it. If you have never down this before you will need to download and install Putty from here http://www.putty.org/
* To use Putty just start it and enter the IP address your router has assigned the Pi and make sure port 22 is entered into the port field
* To work out what IP address your router has assigned the Pi you can either open up lxterminal when the pi first booted up and type in ifconfig and it will give you the Pi’s IP address or you can get this by logging into your router




I will not go into the detail on how to do a standard install of Raspbian off Noobs as the Raspberry Pi website gives great instruction on how to do this.
if you do not know where to download Noobs from you get it here.
http://www.raspberrypi.org/downloads/
This link is to the howto to install Noobs onto the SD card
http://www.raspberrypi.org/help/noobs-setup/


The few extra things you should do over a standard install is
* Change the password from the default password for extra security. 
* I also recommend doing minor overclocking to 800Mhz.
* Don’t forget to enable SSH during setup
* I recommend changing the memory split from 64 to only 32Meg for the video to give more memory to the CPU
* Don’t forget to select your timezone
* Consider changing the hostname if you already have more than one Pi on your network

Set up Rasbian as per the instructions from the Raspberry Pi website and SSH into the Pi
Note as configured this script will download a precompiled version of feathercoind to save you 4 hours of compiling,
if you want to compile it yourself uncommoment thats ection of the script and comment out the bit that downlaods the precompiled one. 

To Download everything off github onto your Pi use the following command

sudo git clone https://github.com/tmuir12/FTC_Raspberry_Pi_Full_Node

Now enter the directory FTC_Raspberry_Pi_Full_Node

cd FTC_Raspberry_Pi_Full_Node/

We now need to make the script executable by typing

sudo chmod 755 feathercoind_node_precompiled.sh

Now we need to start the install script by typing.
./feathercoind_node_precompiled.sh


This will 
* Update the Pi to the latest version
* Install needed applications to run feathercoind, 
* Set up a firewall, that will allow ssh in and feathercoind to talk to other clients
* Download feathercoind
* Create a conf file with input from you to select a password for RDC
* Download a fairly recent blockchain and chainstate to speed up the process of getting it running
* create an /etc/init.d entry to start feathercoind as using ‘pi’ at boot

You are now on the home stretch.

You now need to log into your router and statically assign the IP address to the Pi and enable port forwarding to this IP address both inbound and outbound on port 9336.
You will need to read your router's manual to find out how to do this.

Once you have set up your router its time to test it.
Type sudo reboot
Once the Pi has booted back up SSH back into it
Give it 2 or 3 minutes for the Feathercoin daemon to start up and then to check it go


cd .feathercoin
./feathercoind getinfo
and you should be presented something like this


{
        "version" : 80701,
        "protocolversion" : 60007,
        "walletversion" : 60000,
        "balance" : 0.00000000,
        "blocks" : 444272,
        "timeoffset" : 0,
        "connections" : 100,
        "proxy" : "",
        "difficulty" : 9.85707588,
        "testnet" : false,
        "keypoololdest" : 1414901309,
        "keypoolsize" : 101,
        "paytxfee" : 0.00000000,
        "mininput" : 0.00001000,
        "errors" : ""
}




If you get an error when trying the above command wait another couple of minutes and try again as it does take a fe minutes for feathercoind daemon to fully start up.
Whilst it is catching up it will use about 90% of the CPU but once it has caught up it will only use 2% or 3%
Once you have been online for a day or so you should be able to find your node here
https://bitinfocharts.com/feathercoin/nodes/

You can also look at installing apache mysql and PHP and install a web front end to let you see what is happening by your web browser if you want, but don't forget to open up port 80 on the Pis firewall if you do.
