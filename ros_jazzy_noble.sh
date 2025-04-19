#!/bin/bash

if [ "$1" == "help" ]; then
    echo "Usage: $0 [desktop]"
    echo "  desktop: Install ROS 2 Humble Desktop"
    echo "  base: Install ROS 2 Humble Base"
    exit 0
fi


locale  # check for UTF-8

sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

locale  # verify settings

sudo apt install software-properties-common -y
sudo add-apt-repository universe
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
sudo apt update -y
sudo apt install ros-dev-tools -y
sudo apt update -y
sudo apt upgrade -y

if [ "$1" == "desktop" ]; then
    # Install ROS 2 Jazzy Desktop
    sudo apt install ros-jazzy-desktop
else
    # Install ROS 2 Jazzy Base
    sudo apt install ros-jazzy-ros-base
fi

echo "alias bands='colcon build && source install/setup.bash'" >> ~/.bashrc
echo "alias ros2src='source /opt/ros/jazzy/setup.bash'" >> ~/.bashrc