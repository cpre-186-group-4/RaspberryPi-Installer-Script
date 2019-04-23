#/bin/bash

## go back to the home directory
cd

echo "Installing Python 3"
sudo apt-get install -y python3 python3-pip python-dev python3-dev

echo "Installing PiCamera Python libraries"
sudo apt-get install -y python3-picamera python-picamera

echo "Enabling I2C
dtparam i2c_arm=on
modprobe i2c-dev

echo "Seting up I2C"
sudo apt-get update
sudo apt-get install -y i2c-tools libi2c-dev  
sudo apt-get install -y python-smbus python3-smbus
sudo adduser pi i2c

echo "Done setting up I2C. Here are the devices found"
i2cdetect -y 1

echo "Installing packages for Python development with BerryIMU"
sudo apt-get install -y  

echo "Getting source code for IMU libraries and the scanner software"
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

echo "Enabling SSH"
sudo systemctl enable ssh
sudo systemctl start ssh

echo "Enabling PiCamera"
# Stop if /boot is not a mountpoint
echo "Checking for boot directory"
if ! mountpoint -q /boot; then
echo "Uh oh, the boot folder doesn't exist. Are you sure this is a Raspberry Pi?"
  return 1
fi
echo "Appending PiCamera configuration to boot.txt"
set_config_var start_x 1 /boot/config.txt
CUR_GPU_MEM=$(get_config_var gpu_mem /boot/config.txt)
if [ -z "$CUR_GPU_MEM" ] || [ "$CUR_GPU_MEM" -lt 128 ]; then
echo "Expanding GPU memory to 128 megabytes"
  set_config_var gpu_mem 128 /boot/config.txt
fi
sed /boot/config.txt -i -e "s/^startx/#startx/"
sed /boot/config.txt -i -e "s/^fixup_file/#fixup_file/"

echo "SSH enabled. Connect via SSH or SFTP to the Pi's address: "
hostname -I
