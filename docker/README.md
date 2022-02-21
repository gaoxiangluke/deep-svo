# SLAM

This docker file sets up the environment for [CURLY SLAM](https://github.com/UMich-CURLY/curly_slam).

## Usage
1. Install `docker` and `docker-compose`. See [Wiki](https://github.com/UMich-CURLY/docker_images/wiki) for more details about Docker.
1. Make sure you have Nvidia driver installed.
    - If you are not using Nvidia GPU or just don't want to bother installing the driver, change the first line of the `Dockerfile` to: 
        ```
        FROM ubuntu:20.04
        ```
    - If you want to use `CUDA`, please follow [this guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#linux-distributions) to install `nvidia-container-toolkit`. Maybe skip this step for now if you don't know what `CUDA` is.
1. Clone this repository:
    ```bash
    git clone https://github.com/UMich-CURLY/docker_images.git
    ```
1. Build the Docker image:
    ```bash
:c
    docker build --tag umrobotics/curly_slam . > build.log
    ```
    - See `build.log` for building details. The image may take ~20 minutes to build, so please grab a cup of coffee and relax.
    - If you encounter any problem during this step, please submit a new issue and paste your error message there. We will help you as soon as possible.
1. When you finish the coffee or the container is built, please check `docker-compose.yml`. You may want to change line 44-45 (or somewhere around):
    ```bash
    - /home/$USER/Projects/curly/:/root/ws/
    - /run/media/$USER/CTOS-Storage/rosbag/:/root/ws/rosbag/
    ```
    These two lines will make the folders on your host system available inside the container. For more configuration please see [compose-file](https://docs.docker.com/compose/compose-file/compose-file-v3/).
1. It is a good practice to keep your working files on your host system. In that way, if the container is deleted by accident (which happens a lot), you will not lose your works. Guess how I learn this~
1. Run this command to open a new container with your `docker-compose.yml` config:
    ```bash
    docker-compose run slam
    ```
1. Voilà！ Now try to build your ROS workspace!


## FAQ

### How to open the container I used last time?

A traditional way is:
```bash
docker container ls -all
# check which container is the one you want
# to use and copy the CONTAINER ID, then run:
docker container start [CONTAINER ID]
docker container attach [CONTAINER ID]
```

A more modern way is:
1. Install VS Code.
1. Install the Docker extension.
1. See everything and control everything in the Docker tab.

### Can I use GUI in this container?

Yes, you can. Just run `xhost +` on your host system first, and then you can use any GUI programs as you want in the container. The GUI window will show up on your host system.

Note: `xhost +` is simple but unsecure. Check other solutions [here](http://wiki.ros.org/docker/Tutorials/GUI).

### Memory leak when running `roscore`?
Use ulimits config of docker to limit the number of file descriptor. This is fixed by adding `ulimits` to `docker-compose.yml`. Detail information can be found here:
https://answers.ros.org/question/336963/rosout-high-memory-usage/.
