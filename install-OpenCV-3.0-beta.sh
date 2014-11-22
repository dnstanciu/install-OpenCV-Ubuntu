#!/bin/bash

##############################################
### Script for installing OpenCV 3.0 beta. 
###	
### Installs OpenCV in ~/src/opencv
### 
###	Tested with:
###     - Ubuntu 14.04 LTS 64 bits
###     - OpenCV 3.0 beta
###
### Author: Dragos Stanciu
###
### Based on: http://goo.gl/OQbMNf
##############################################

# update repos and upgrade packages
sudo apt-get update
sudo apt-get upgrade

# required libraries
sudo apt-get -y install libopencv-dev build-essential cmake git libgtk2.0-dev pkg-config python-dev python-numpy libdc1394-22 libdc1394-22-dev libjpeg-dev libpng12-dev libtiff4-dev libjasper-dev libavcodec-dev libavformat-dev libswscale-dev libxine-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev libtbb-dev libqt4-dev libfaac-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev x264 v4l-utils unzip

FOLDER_NAME="opencv"

# go to home directory
cd

# create directory for libraries
mkdir src

# go to sources directory
cd src

# create opencv directory
mkdir ${FOLDER_NAME}

# enter directory
cd ${FOLDER_NAME}

# download OpenCV 3 beta archive
wget https://github.com/Itseez/opencv/archive/3.0.0-beta.zip -O opencv-3.0.0-beta.zip

# extract contents
unzip opencv-3.0.0-beta.zip

# enter directory
cd opencv-3.0.0-beta

# create build directory for compilation
mkdir build

# enter build directory
cd build

# setup OpenCV 3.0 beta project with CMake
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D WITH_QT=ON -D WITH_OPENGL=ON ..

# compile project
make -j $(nproc)

# install libraries
sudo make install

# add path of OpenCV libraries to Ubuntu's default library search paths
sudo /bin/bash -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf' 

# update search libraries
sudo ldconfig