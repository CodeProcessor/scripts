#!/bin/bash -       
#title          :caffe.sh
#description    :INSTALL CAFFE ON UBUNTU OR DEBIAN
#author		 	:DulanJ
#date           :2018/04/18
#version        :0.1    
#usage		 	:bash mkscript.sh
#notes          :apt-get didnt work for protobuf
#links			:http://caffe.berkeleyvision.org/install_apt.html
#bash_version   :GNU bash, version 4.4.12(1)-release
#==============================================================================
# |         THIS SCRIPT IS TESTED CORRECTLY ON         |
# |----------------------------------------------------|
# | OS             | OpenCV       | Test | Last test   |
# |----------------|--------------|------|-------------|
# | Rsapbian Strech| caffe 1.0.0  | OK   | 18 Mar 2018 |
#==============================================================================

sudo apt-get install -y libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
sudo apt-get install -y --no-install-recommends libboost-all-dev

sudo apt-get install -y libgflags-dev libgoogle-glog-dev liblmdb-dev

#PIP installs
wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
pip install protobuf


# glog
wget -nc https://github.com/google/glog/archive/v0.3.3.tar.gz
rm -r glog-0.3.3
tar zxvf v0.3.3.tar.gz
cd glog-0.3.3
./configure
make && make install
cd..

# gflags
wget https://github.com/schuhschuh/gflags/archive/master.zip
rm -r gflags-master
unzip master.zip
cd gflags-master
mkdir build && cd build
export CXXFLAGS="-fPIC" && cmake .. && make VERBOSE=1
make && make install
cv ../..

# lmdb
rm -r lmdb
git clone https://github.com/LMDB/lmdb
cd lmdb/libraries/liblmdb
make && make install
cv ../../..

#ATLAS
sudo apt-get install libatlas-base-dev
sudo apt-get install python-skimage

#Download caffe
wget -nc https://github.com/BVLC/caffe/archive/master.zip
rm -r caffe-master
unzip master.zip
cd caffe-master
mkdir build
cd build
cmake ..
make all
sudo make install
make runtest

cd ..
echo "export PYTHONPATH=$(pwd)/python:$PYTHONPATH" >> ~/.bashrc