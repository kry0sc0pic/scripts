sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade

sudo apt-get install libssl-dev libusb-1.0-0-dev libudev-dev pkg-config libgtk-3-dev

sudo apt-get install git wget cmake build-essential

sudo apt-get install libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev at

git clone https://github.com/IntelRealSense/librealsense.git

cd librealsense

sudo apt-get install -y v4l-utils

./scripts/setup_udev_rules.sh

./scripts/patch-realsense-ubuntu-lts-hwe.sh

mkdir build && cd build

cmake ../ -DBUILD_EXAMPLES=true

sudo make uninstall && make clean && make && sudo make install

sudo usermod -aG video $USER

sudo apt install ros-$ROS_DISTRO-realsense2-*
