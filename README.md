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
wget https://github.com/cpre-186-group-4/RaspberryPi-Installer-Script/blob/master/install.sh
chmod +x install.sh
./install.sh
```
