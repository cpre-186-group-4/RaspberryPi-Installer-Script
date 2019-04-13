# RaspberryPi-Installer-Script
A script that installs and builds the latest version of the open-source 3D scanner software for the Raspberry Pi

## Instructions:
### 1.) Flash the [latest Raspbian OS](https://www.raspberrypi.org/downloads/raspbian/) onto an SD card
The [NOOBS installer](https://www.raspberrypi.org/downloads/noobs/) will work for this, but you can save space by
[flashing Raspbian](https://www.raspberrypi.org/documentation/installation/installing-images/README.md). Because 
the scanner software doesn't need any graphics libraries, it is also possible to use a lite version of Raspbian
### 2.) Configuration
Run the command `sudo raspi-config`.
#### Expand Filesystem
Under `Advanced Options` is the `Expand Filesystem` option. Use this to ensure that all space on the SD card can 
be used.
#### Enable peripherals
From the main menu, go to the `Interfacing Options` tab. Here you need to enable the __Camera__, __SSH__, and __SPI__
interfaces. Please note that if SSH is enabled on a public network, people _will_ atttempt to hack it, so please 
change the Pi's password with the command `sudo passwd`
### 3.) Updates
Update existing softare in this Raspbian distribution with the following commands
```shell
sudo apt-get update
sudo apt-get upgrade
```
### 4.) Install Git
One way to get the latest version of the installer script is to use Git. Install the Git package with the 
command `sudo apt-get install git`.
### 5.) Download and run the installer script
1. Clone the [Installer Script repository](https://github.com/cpre-186-group-4/RaspberryPi-Installer-Script) with the command `git clone https://github.com/cpre-186-group-4/RaspberryPi-Installer-Script.git`
  * It is also possible to download the script with `wget https://github.com/cpre-186-group-4/RaspberryPi-Installer-Script/blob/master/install.sh`
2. Make the file executable with the command `chmod +x instal.sh`
3. Run the program with `./install.sh`
