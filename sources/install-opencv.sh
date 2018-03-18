#!/bin/bash -       
#title          :caffe.sh
#description    :INSTALL OPENCV ON UBUNTU OR DEBIAN
#author		 	:DulanJ
#date           :2018/04/18
#version        :0.1    
#usage		  	:bash mkscript.sh
#notes          :This script was taken from below link and modified
#link			:(https://github.com/milq/milq/blob/master/scripts/bash/install-opencv.sh)
#bash_version   :GNU bash, version 4.4.12(1)-release
#==============================================================================

######################################
# INSTALL OPENCV ON UBUNTU OR DEBIAN #
######################################

# |         THIS SCRIPT IS TESTED CORRECTLY ON         |
# |----------------------------------------------------|
# | OS             | OpenCV       | Test | Last test   |
# |----------------|--------------|------|-------------|
# | Ubuntu 17.04   | OpenCV 3.4.1 | OK   | 14 Mar 2018 |
# | Debian 9.3     | OpenCV 3.4.0 | OK   | 17 Feb 2018 |
# | Ubuntu 16.04.2 | OpenCV 3.2.0 | OK   | 20 May 2017 |
# | Debian 8.8     | OpenCV 3.2.0 | OK   | 20 May 2017 |
# | Debian 9.0     | OpenCV 3.2.0 | OK   | 25 Jun 2017 |

# VERSION TO BE INSTALLED

OPENCV_VERSION='3.4.1'


# 1. KEEP UBUNTU OR DEBIAN UP TO DATE
echo "Downloading updates..."
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get -y autoremove


# 2. INSTALL THE DEPENDENCIES

# Build tools:
echo "====== Install Build Tools ========="
sudo apt-get install -y build-essential cmake

# GUI (if you want to use GTK instead of Qt, replace 'qt5-default' with 'libgtkglext1-dev' and remove '-DWITH_QT=ON' option in CMake):
echo "====== Install QT5 ========="
sudo apt-get install -y qt5-default libvtk6-dev

# Media I/O:
echo "====== Install Media I/O Tools ========="
sudo apt-get install -y zlib1g-dev libjpeg-dev libwebp-dev libpng-dev libtiff5-dev libjasper-dev libopenexr-dev libgdal-dev

# Video I/O:
echo "====== Install Video I/O Tools ========="
sudo apt-get install -y libdc1394-22-dev libavcodec-dev libavformat-dev libswscale-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev yasm libopencore-amrnb-dev libopencore-amrwb-dev libv4l-dev libxine2-dev

# Parallelism and linear algebra libraries:
echo "====== Install Parallelism and linear algebra libraries ========="
sudo apt-get install -y libtbb-dev libeigen3-dev

# Python:
echo "====== Install Python ========="
sudo apt-get install -y python-dev python-tk python-numpy python3-dev python3-tk python3-numpy

# Java:
echo "====== Install Java ========="
sudo apt-get install -y ant default-jdk

# Documentation:
echo "====== Install Documentation ========="
sudo apt-get install -y doxygen


# 3. INSTALL THE LIBRARY

sudo apt-get install -y unzip wget

echo "====== Downloading OpenCV-contrib ========="

mkdir opencv-contrib
cd opencv-contrib
wget -nc https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip
unzip ${OPENCV_VERSION}.zip
rm -r OpenCV-Contrib
mv opencv_contrib-${OPENCV_VERSION} OpenCV-Contrib
# mv ${OPENCV_VERSION}.zip opencv-contrib-${OPENCV_VERSION}.zip
cd ..

echo "====== Downloading OpenCV ========="
wget -nc https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip
unzip ${OPENCV_VERSION}.zip
# rm ${OPENCV_VERSION}.zip
rm -r OpenCV
mv opencv-${OPENCV_VERSION} OpenCV
# mv ${OPENCV_VERSION}.zip opencv-${OPENCV_VERSION}.zip
cd OpenCV
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D WITH_IPP=OFF \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D INSTALL_C_EXAMPLES=OFF \
	-D INSTALL_PYTHON_EXAMPLES=OFF \
	-D OPENCV_EXTRA_MODULES_PATH=../../opencv-contrib/OpenCV-Contrib/modules \
	-D BUILD_EXAMPLES=OFF ..

# cmake -DWITH_QT=ON -DWITH_OPENGL=ON -DFORCE_VTK=ON -DWITH_TBB=ON -DWITH_GDAL=ON \
#  -DINSTALL_C_EXAMPLES=OFF \
#  -DWITH_XINE=ON -DBUILD_EXAMPLES=OFF -DENABLE_PRECOMPILED_HEADERS=OFF \
#  -DOPENCV_EXTRA_MODULES_PATH=./opencv-contrib/OpenCV-Contrib/modules ..

make -j$(nproc)
sudo make install
sudo ldconfig


# 4. EXECUTE SOME OPENCV EXAMPLES AND COMPILE A DEMONSTRATION

# To complete this step, please visit 'http://milq.github.io/install-opencv-ubuntu-debian'.