# Scripts
Scripts are meant for Ubuntu 22.04 unless specifically mentioned.


1. ROS 2 Humble
Installs ROS using the Ubuntu Debian Packages. 
```bash
./ros_humble_jammy.sh desktop # Installs ROS Humble Desktop
# ---- OR
./ros_humble_jammy.sh  # Installs ROS Humble Base
```

2. PX4 Development
-  ROS Humble Desktop (using #1).
-  PX4 1.15.4 SITL Simulation
-  PX4 1.15 ROS Workspace (`px4_msgs`, `px4_ros_com` and XRCE DDS Agent).
-  QGroundControl Daily and Stable Build.
```bash
./px4_development.sh
```

3. PX4 Companion
- ROS Humble Base (using #1).
- PX4 1.15 Workspace.
```bash
./px4_companion.sh
```
