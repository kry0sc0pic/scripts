#!/bin/bash

# Install ROS Humble Desktop
./ros_humble_jammy.sh

# Create ROS WS
mkdir -p px4_ws/src
cd px4_ws/src

# Clone PX4 ROS 2
git clone https://github.com/PX4/px4_ros_com.git
cd px4_ros_com
git switch release/v1.15

# Clone PX4 Messages
git clone https://github.com/PX4/px4_msgs.git
cd px4_msgs
git switch release/v1.15

# Build Workspace
cd ..
colcon build


