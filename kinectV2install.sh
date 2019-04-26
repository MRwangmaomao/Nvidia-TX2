#!/bin/bash
# Kinect libfeenect iai_kinect 
# v 0.36
# writer: Wang Peirong
cur_dir=$(pwd)

echo "进入kinect_install脚本"

#下载 libfreenect2 源码
echo "开始下载libfreenect2"
cd ~
git clone https://github.com/OpenKinect/libfreenect2.git

#下载upgrade deb 文件
echo "开始下载upgrade deb 文件"
cd libfreenect2
cd depends
chmod +x download_debs_trusty.sh
./download_debs_trusty.sh

echo "安装编译工具   libusb.  TurboJPEG"
#安装编译工具
sudo apt-get --yes --force-yes install build-essential cmake pkg-config
#安装 libusb. 版本需求 >= 1.0.20.
sudo dpkg -i debs/libusb*deb
#安装TurboJPEG：

sudo apt-get --yes --force-yes install libturbojpeg libjpeg-turbo8-dev

#安装 OpenGL
echo "开始安装openGL" 
sudo dpkg -i debs/libglfw3*deb
sudo apt-get --yes --force-yes install -f
sudo apt-get --yes --force-yes install libgl1-mesa-dri-lts-vivid

#安装 Openni2
echo "开始安装openni2" 
sudo apt-get --yes --force-yes install libopenni2-dev

#Build
echo "开始libfreenect2的build"
cd ..
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$HOME/freenect2 -DENABLE_CXX11=ON
make
make install

#设置udev规则：
echo "设置udev规则"
sudo cp ../platform/linux/udev/90-kinect2.rules /etc/udev/rules.d/
cd ~

#建立自己的工作空间
echo "建立自己的工作空间"
mkdir -p ~/catkin_kinect/src
cd ~/catkin_kinect/src
catkin_init_workspace
cd ..
catkin_make
cd ~/catkin_kinect/src
#下载 iai_kinect2 源码
echo "开始下载iai_kinect2"
git clone https://github.com/code-iai/iai_kinect2
cd iai_kinect2
rosdep install -r --from-paths .
cd ~/catkin_kinect
catkin_make -DCMAKE_BUILD_TYPE="Release"

echo "source ~/catkin_kinect/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc
