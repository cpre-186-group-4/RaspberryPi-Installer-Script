#/bin/bash

## go back to the home directory
echo "Performing package update/upgrade"
sudo apt-get update
sudo apt-get upgrade

echo "Enabling i2c"
sudo raspi-config nonint do_i2c 0
echo "Done setting up I2C. Here are the devices found"
i2cdetect -y 1
cd

echo "Enabling SSH"
sudo raspi-config nonint do_ssh 0
echo "SSH enabled. Connect via SSH or SFTP to the Pi's address: "
hostname -I

echo "Enabling autologin"
sudo raspi-config nonint do_boot_behaviour B2

echo "Enabling camera interface"
sudo raspi-config nonint do_camera 0


echo "Installing Python 3"
sudo apt-get install -y python3 python3-pip python-dev python3-dev

echo "Installing PiCamera Python libraries"
sudo apt-get install -y python3-picamera python-picamera

echo "Seting up I2C libraries"
sudo apt-get update
sudo apt-get install -y i2c-tools libi2c-dev
sudo apt-get install -y python-smbus python3-smbus
sudo adduser pi i2c

echo "Installing Git"
sudo apt-get install -y git

echo "Getting source code for IMU libraries and the scanner software"
rm -rf BerryIMU/
rm -rf Scanner/
git clone https://github.com/cpre-186-group-4/Scanner.git
git clone https://github.com/ozzmaker/BerryIMU.git

echo "Building examples for BerryIMU"
cd BerryIMU/compass_tutorial01_basics/
gcc -o compass_tutorial01 compass_tutorial01.c -lm
cd ../compass_tutorial02_tilt_compensation/
gcc -o compass_tutorial02 compass_tutorial02.c -lm
cd ../compass_tutorial03_calibration/
gcc -o compass_tutorial03 compass_tutorial03.c -lm
gcc -o compass_tutorial03_calibration compass_tutorial03_calibration.c
cd ../gyro_accelerometer_tutorial01_angles/
gcc -o gyro_accelerometer_tutorial01 -l rt gyro_accelerometer_tutorial01.c -lm
cd ../gyro_accelerometer_tutorial03_kalman_filter/
gcc -o gyro_accelerometer_tutorial03 -l rt gyro_accelerometer_tutorial03.c -lm

echo "Installation finished"
