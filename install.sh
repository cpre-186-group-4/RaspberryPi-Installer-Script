#/bin/bash

## go back to the home directory
cd

echo "Seting up I2C"
sudo apt-get update
sudo apt-get install -y i2c-tools libi2c-dev  
sudo adduser pi i2c

echo "Done setting up I2C. Here are the devices found"
i2cdetect -y 1

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

echo "Installing packages for Python development with BerryIMU"
sudo apt-get install -y python-smbus python3-smbus python-dev python3-dev
