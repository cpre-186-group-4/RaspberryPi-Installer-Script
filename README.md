# RaspberryPi-Installer-Script
A script that installs and builds the latest version of the open-source 3D scanner software for the Raspberry Pi

## Instructions:
### 1.) Flash the [latest Raspbian OS](https://www.raspberrypi.org/downloads/raspbian/) onto an SD card
The [NOOBS installer](https://www.raspberrypi.org/downloads/noobs/) will work for this, but you can save space by
[flashing Raspbian](https://www.raspberrypi.org/documentation/installation/installing-images/README.md). Because 
the scanner software doesn't need any graphics libraries, it is also possible to use a lite version of Raspbian

#### Headless Pi
If a keyboard or screen is not available, don't worry; there is still hope, there are resources [here](https://desertbot.io/blog/headless-pi-zero-w-wifi-setup-windows) and elsewhere to use SSH with the Pi and a computer. There are only a few extra steps that to into setting up the Pi, depending on whether you want to connect to the computer's ethernet, a wireless network, or through USB

##### Wireless Network
1.) Create a new blank file called "ssh" (notice there is no file extension) and place it in the root of the boot partition on the SD card

2.) Set up the network
###### Windows
Per the instructions [here](https://answers.microsoft.com/en-us/windows/forum/windows_10-networking/how-do-i-set-up-an-ad-hoc-wifi-network-in-windows/0caa92d8-e02f-4e7f-aa5c-0abf10ed2039), it is possible to allow Windows 10 to create a new ad-hoc network. This might be nice if you don't want to/can't connect your Pi to a router. Basically:
Open up Command Prompt (you will need admin permissions)

* Create a hostednetwork with the command `netsh wlan set hostednetwork mode=allow ssid="NETWORK-NAME" key="NETWORK-PASSWORD"`
* Enable/start the network with `netsh wlan start hostednetwork`
* To connect this network to your Internet connection, [follow this tutorial](https://www.howto-connect.com/create-wireless-ad-hoc-internet-connection-on-windows-10/)

###### Ubuntu
Create a hotspot (unfortunately this might prevent your machine from internet access)
Your hotspot name and password are in the hotspot settings


3.) Create another text file called "wpa_supplicant.conf" (notice there is a file extension) and again place it in the root of the boot partition on the SD card. Inside type/copy the following:
```
country=US
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
   ssid="NETWORK-NAME"
   psk="NETWORK-PASSWORD"
}
```
where `US` is the acronym of the country in which you live (for keyboard/language purposes), `NETWORK-NAME` is the name of the network you would like to connect to, and `NETWORK-PASSWORD` is the password for that network. (See more about the network options below).

Note: if you would like the Pi to be able to connect to multiple networks, this works as well:
```
country=US
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
   ssid="NETWORK1-NAME"
   psk="NETWORK1-PASSWORD"
}

network={
   ssid="NETWORK2-NAME"
   psk="NETWORK2-PASSWORD"
}
```

Also note that if the Pi has already booted up with this SD card, the wpa_supplicant file will reside in _/etc/wpa_supplicant/wpa_supplicant.conf_

4.) Eject the disk

##### USB (Windows Only)
[Adafuit] has a couple good tutorials on how to set up the Pi to connect via USB, so no WiFi is necessary. They are [here](https://cdn-learn.adafruit.com/downloads/pdf/raspberry-pi-zero-creation.pdf) and [here]
(https://learn.adafruit.com/turning-your-raspberry-pi-zero-into-a-usb-gadget/ethernet-gadget).


### 2.) Configuration
Run the command `sudo raspi-config`.
#### Expand Filesystem
Under `Advanced Options` is the `Expand Filesystem` option. Use this to ensure that all space on the SD card can 
be used.
#### Enable Peripherals
From the main menu, go to the `Interfacing Options` tab. Here you need to enable the __Camera__, __SSH__, and __I2C__
interfaces. Please note that if SSH is enabled when your Pi is connected to a public network, people _will_ attempt to log into your Pi and _won't_ always do so with the best intentions. This has been a concern since [April 2012](https://www.raspberrypi.org/blog/updated-debian-arch-linux-arm-images/) when SSH was disabled by default. 
change the Pi's password with the command `sudo passwd`
### 3.) Updates
Update existing softare in this Raspbian distribution with the following commands
```bash
sudo apt-get update
sudo apt-get upgrade
```
### 4.) Install Git
One way to get the latest version of the installer script is to use Git. Install the Git package with the 
command `sudo apt-get install git`.
### 5.) Download and Run the Installer Script
1. Clone the [Installer Repository](https://github.com/cpre-186-group-4/RaspberryPi-Installer-Script) with the command `git clone https://github.com/cpre-186-group-4/RaspberryPi-Installer-Script.git`
2. Make the file _install.sh_ executable with the command `chmod +x RaspberryPi-Installer-Script/install.sh`.
3. Run the program with `RaspberryPi-Installer-Script/install.sh`

To recap, these are all the commands that need to be done:
```bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install git
git clone https://github.com/cpre-186-group-4/RaspberryPi-Installer-Script.git
cd RaspberryPi-Installer-Script
chmod +x install.sh
./install.sh
```
#### Git Alternative: [Wget](https://www.gnu.org/software/wget/)
Although Git makes version control easy, there are probably some cases where one may not want to install Git. Instead, use the following commands, which are all built into Raspbian:
```bash
wget https://raw.githubusercontent.com/cpre-186-group-4/RaspberryPi-Installer-Script/master/install.sh
chmod +x install.sh
./install.sh
```

