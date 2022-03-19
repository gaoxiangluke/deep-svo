FROM pytorch/pytorch:1.8.0-cuda11.1-cudnn8-devel
LABEL org.opencontainers.image.authors="rzh@umich.edu,junzhewu@umich.edu"
LABEL description="Container for ROB 530"
LABEL version="0.5"
USER root
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y locales \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=en_US.UTF-8

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics,compute,utility,display

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
# install libraries and  tools
RUN apt-get update && apt-get -y install \
    python3 \
    python3-pip \
    libsm6 \
    libxext6 \
    libxrender-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# install python dependencies
RUN pip3 install --upgrade pip
RUN pip3 install torch~=1.8 torchvision opencv-python-headless~=3.4 timm

# install ROS
RUN sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

RUN sudo apt install curl
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

RUN sudo apt-get update

RUN sudo apt-get install -y --no-install-recommends ros-melodic-desktop-full

# install gitstatus
# https://github.com/romkatv/gitstatus/releases/tag/v1.3.1
RUN mkdir -p /root/.cache/gitstatus \
    && wget https://github.com/romkatv/gitstatus/releases/download/v1.5.1/gitstatusd-linux-x86_64.tar.gz -O - \
    | tar -zx -C /root/.cache/gitstatus/

# install pytorch libraries
RUN mkdir /root/slam_lib/

WORKDIR /root/
RUN sudo wget https://download.pytorch.org/libtorch/cu110/libtorch-cxx11-abi-shared-with-deps-1.7.0%2Bcu110.zip
RUN unzip libtorch-cxx11-abi-shared-with-deps-1.7.0+cu110.zip

#install slam libraries
WORKDIR /root/slam_lib/
RUN git clone https://github.com/strasdat/Sophus.git
RUN /bin/bash -c 'cd Sophus; git checkout a621ff;'
# Apply fix for known Sophus bug
COPY change/so2.cpp Sophus/sophus
RUN /bin/bash -c 'mkdir Sophus/build; cd Sophus/build; cmake ..'
RUN /bin/bash -c 'cd Sophus/build; sudo make install'

RUN git clone https://github.com/uzh-rpg/fast.git  fast/
RUN cd fast/ \
    && mkdir -p build \
    && cd build \
    && cmake .. \
    && sudo make install -j16
RUN sudo wget https://github.com/RainerKuemmerle/g2o/archive/20160424_git.tar.gz -O g2o-20160424_git.tar.gz
RUN tar xvzf g2o-20160424_git.tar.gz
RUN cd g2o-20160424_git/ \
    && mkdir -p build \
    && cd build \
    && cmake .. \
    && sudo make install -j16
RUN sudo wget https://gitlab.com/libeigen/eigen/-/archive/3.2.10/eigen-3.2.10.tar.gz
RUN tar -xf eigen-3.2.10.tar.gz
RUN cd eigen-3.2.10/ \
    && mkdir -p build \
    && cd build \
    && cmake .. \
    && sudo make install









