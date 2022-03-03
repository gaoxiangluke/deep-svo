FROM pytorch/pytorch:1.8.0-cuda11.1-cudnn8-devel

LABEL version="0.5"

USER root

# scipy, tensorboard
RUN pip install scipy
RUN pip install tensorboard
RUN pip install -U scikit-learn

# build essential, cmake, vim, git
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y install cmake
RUN apt-get update && apt-get install -y vim
RUN apt-get install -y build-essential
RUN apt-get update && apt-get install -y git-all

# install libraries and  tools
RUN apt-get update && apt-get install -y --no-install-recommends \
        sudo \
        dialog \
        apt-utils \
        git \
        mercurial \
        pkg-config \
        mesa-utils \
        libxau-dev \
        libxdmcp-dev \
        libxcb1-dev \
        libxext-dev \
        libx11-dev \ 
        git \
        tmux \
        wget \
        curl \
        cmake \
        vim \ 
        build-essential \
        unzip \
        autoconf \
        autogen \
        automake \
        libtool \
        mlocate \
        zlib1g-dev \
        libopenblas-dev \
        libflann-dev \
        libpcl-dev \
        libboost-all-dev \
        libsuitesparse-dev \
        libtbb-dev \
        libusb-1.0-0-dev \
        libgtest-dev \
        pkg-config \
        cmake-curses-gui \
        gdb \
        clang \
        emacs \
        libpcap-dev \
        gnupg2 \
        x11-xserver-utils \
        lsb-release \
        tilix \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

# Ros
RUN sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

RUN sudo apt install curl
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

RUN sudo apt-get update

RUN sudo apt-get install -y --no-install-recommends ros-melodic-desktop-full


