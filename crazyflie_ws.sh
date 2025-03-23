sudo apt-get update -y
sudo apt-get upgrade -y

cd ~

sudo apt install git python3-pip libxcb-xinerama0 libxcb-cursor0
pip3 install --upgrade pip

pip3 install cfclient

sudo groupadd plugdev
sudo usermod -a -G plugdev $USER

cat <<EOF | sudo tee /etc/udev/rules.d/99-bitcraze.rules > /dev/null
# Crazyradio (normal operation)
SUBSYSTEM=="usb", ATTRS{idVendor}=="1915", ATTRS{idProduct}=="7777", MODE="0664", GROUP="plugdev"
# Bootloader
SUBSYSTEM=="usb", ATTRS{idVendor}=="1915", ATTRS{idProduct}=="0101", MODE="0664", GROUP="plugdev"
# Crazyflie (over USB)
SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="5740", MODE="0664", GROUP="plugdev"
EOF

sudo udevadm control --reload-rules
sudo udevadm trigger

sudo apt install libboost-program-options-dev libusb-1.0-0-dev
pip3 install rowan nicegui

sudo apt-get install ros-humble-motion-capture-tracking

pip3 install cflib transforms3d
sudo apt-get install ros-humble-tf-transformations

cd ~
mkdir -p crazyflie_ws/src
cd crazyflie_ws/src
git clone https://github.com/IMRCLab/crazyswarm2 --recursive

cd ..

cd ~

sudo apt-get install -y swig
git clone --recursive https://github.com/bitcraze/crazyflie-firmware.git
cd crazyflie-firmware
make cf2_defconfig
make bindings_python
cd build
python3 setup.py install --user

echo "export PYTHONPATH=$HOME/crazyflie-firmware/build:$PYTHONPATH" >> ~/.bashrc

reboot