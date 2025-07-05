#!/bin/bash

# Install Deps
sudo apt-get install -y git 


# Install ROS 2 Humble
#chmod +x ./ros_humble_jammy.sh
#./ros_humble_jammy.sh desktop

# Change Directory
cd ~

# Download PX4
git clone https://github.com/PX4/PX4-Autopilot.git
cd PX4-Autopilot

# Checkout
git checkout v1.15.4

# Clone Submodules
git submodule update --init --recursive

# Install Dependencies
bash ./Tools/setup/ubuntu.sh

# Build SITL
make px4_sitl

# Install Python Dependencies
pip install --user -U empy==3.3.4 pyros-genmsg setuptools==68

# Install ROS 2 Dependencies
cd ..
git clone https://github.com/eProsima/Micro-XRCE-DDS-Agent.git
cd Micro-XRCE-DDS-Agent
mkdir build
cd build
cmake ..
make
sudo make install
sudo ldconfig /usr/local/lib/

# Create Workspace
cd ../..

mkdir -p px4_ws/src
cd px4_ws/src

# Clone PX4
git clone https://github.com/PX4/px4_msgs.git
cd px4_msgs
git checkout release/1.15

# Clone PX4 Firmware
cd ..
git clone https://github.com/PX4/px4_ros_com.git
cd px4_ros_com
git switch release/v1.15

# Build Workspace
cd ../..
colcon build

# Download QGroundControl Daily
cd ..
wget https://d176tv9ibo4jno.cloudfront.net/builds/master/QGroundControl-x86_64.AppImage
mv QGroundControl-x86_64.AppImage QGroundDaily.AppImage
chmod +x QGroundDaily.AppImage

# Download QGroundControl Stable
sudo usermod -a -G dialout $USER
sudo apt-get remove modemmanager -y
sudo apt install gstreamer1.0-plugins-bad gstreamer1.0-libav gstreamer1.0-gl -y
sudo apt install libfuse2 -y
sudo apt install libxcb-xinerama0 libxkbcommon-x11-0 libxcb-cursor-dev -y

wget https://d176tv9ibo4jno.cloudfront.net/latest/QGroundControl.AppImage
mv QGroundControl.AppImage QGroundStable.AppImage
chmod +x QGroundStable.AppImage

# Reboot System
sudo reboot
