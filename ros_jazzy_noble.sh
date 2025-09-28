#!/bin/bash

if [ "$1" == "help" ]; then
    echo "Usage: $0 [desktop]"
    echo "  desktop: Install ROS 2 Jazzy Desktop"
    echo "  base: Install ROS 2 Jazzy Base"
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

sudo apt update && sudo apt install curl -y
export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}')
curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo ${UBUNTU_CODENAME:-${VERSION_CODENAME}})_all.deb"
sudo dpkg -i /tmp/ros2-apt-source.deb


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
