# TX2


## 刷机

JetPack 3.3 : https://developer.nvidia.com/embedded/jetpack-3_3

刷机过程中如果提示需要重新设置IP，可以先退出来，然后将已经装好的系统取消掉，安装剩余的部分即可。

## 安装ROS(Ubuntu 16.04)


## 安装turtlebot2驱动(ROS Kinetic)


## 安装KinectV2相机驱动
[install](kinectV2install.sh)

## 安装ceres非线性优化库

```
cd ~
git clone https://ceres-solver.googlesource.com/ceres-solver
sudo apt-get -y install cmake libgoogle-glog-dev libatlas-base-dev libeigen3-dev libsuitesparse-dev
sudo add-apt-repository ppa:bzindovic/suitesparse-bugfix-1319687
sudo apt-get update && sudo apt-get install libsuitesparse-dev
mkdir ceres-bin
cd ceres-bin
cmake ../ceres-solver
make -j3
sudo make install
```

## 安装小觅相机


## 安装测试VINS_Fusion


## 参考资料
https://jkjung-avt.github.io/