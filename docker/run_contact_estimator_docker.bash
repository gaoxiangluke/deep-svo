container_name=$1

xhost +local:
docker run -it --net=host --gpus all  \
  --user=root \
  -e DISPLAY=$DISPLAY \
  -e QT_GRAPHICSSYSTEM=native \
  -e NVIDIA_DRIVER_CAPABILITIES=all \
  -e XAUTHORITY \
  -e USER=root \
  --workdir=/root \
  -v "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  -v "/etc/passwd:/etc/passwd:rw" \
  -e "TERM=xterm-256color" \
  -v "/home/luke/Documents/Academic/535/proj/deep-svo:/root/project" \
  -v "/home/luke/Documents/Academic/535/proj/data:/root/data" \
  --device=/dev/dri:/dev/dri \
  --name=${container_name} \
  --security-opt seccomp=unconfined \
  deep_svo/devel