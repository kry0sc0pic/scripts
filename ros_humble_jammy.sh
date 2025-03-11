#!/bin/bash

if [ "$1" == "help" ]; then
    echo "Usage: $0 [desktop]"
    echo "  desktop: Install ROS 2 Humble Desktop"
    echo "  base: Install ROS 2 Humble Base"
    exit 0
fi

# Locale
locale  # check for UTF-8

sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

locale  # verify settings

# Universe repository
sudo apt install software-properties-common
sudo add-apt-repository universe

# GPG Key
sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
# Add to sources list
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

# Update & Upgrade
sudo apt update && sudo apt upgrade -y


if [ "$1" == "desktop" ]; then
    # Install ROS 2 Humble
    sudo apt install ros-humble-desktop
else
    # Install ROS 2 Humble
    sudo apt install ros-humble-ros-base
fi

# Dev Tools
sudo apt install ros-dev-tools

# Add Aliases
echo "alias bands='colcon build && source install/setup.bash'" >> ~/.bashrc
echo "alias ros2src='source /opt/ros/humble/setup.bash'" >> ~/.bashrc