# CNN-SVO
(Top) camera frames (Bottom) depth maps of the keyframes from Monodepth
<p align="center">
 <img src="https://github.com/yan99033/CNN-SVO/blob/master/gif/kitti_preview.gif" width="723" height="224">
 <img src="https://github.com/yan99033/CNN-SVO/blob/master/gif/robotcar_preview.gif" width="723" height="224">
</p>

Demo: https://www.youtube.com/watch?v=4oTzwoby3jw

Paper: [CNN-SVO: Improving the Mapping in Semi-Direct Visual Odometry Using Single-Image Depth Prediction](https://arxiv.org/pdf/1810.01011.pdf)

This is an extension of the SVO with major improvements for the forward facing camera with the help of monocular depth estimation from CNN.

We tested this code with ROS Kinetic on Ubuntu 16.04.

There are two ways to make it work
1. [Online mode](#online-mode)
2. [Offline mode](#offline-mode)

#### Dataset
We use [KITTI Odometry sequences](http://www.cvlibs.net/datasets/kitti/eval_odometry.php) and [Oxford Robotcar dataset](http://robotcar-dataset.robots.ox.ac.uk/datasets/) to evaluate the robustness of our method.

We provide camera parameters for both datasets. Running a sequence requires setting the directory that keeps the images (also directory to their corresponding depth maps if you are using [Offline mode](#offline-mode)).

Unfortunately, getting Oxford Robotcar dataset to work is not straightforward. Here is the rough idea of what do you need to do to preprocess Oxford Robotcar dataset images:
1. Pick a sequence to download
2. Use the SDK to get the RGB images
3. Crop the images to match the aspect ratio (1248x376) of images in KITTI dataset
4. (For running [Offline mode](#offline-mode)) Save the depth maps of those images

#### Online mode
1. Clone the [monodepth-cpp repo](https://github.com/yan99033/monodepth-cpp) and follow the instructions
2. Make sure the library is successfully built by running the *inference_monodepth* executable
3. Set the image directory in `rpg_svo/svo_ros/param/vo_kitti.yaml`
4. Make sure the images are colour (not greyscale) images

**NOTE:** If you are having difficulty compiling the library, you can still visualize the results using the [Offline mode](#offline-mode)

#### Offline mode
1. Clone the [Monodepth repo](https://github.com/mrharicot/monodepth) and follow the *Testing* instructions
2. Modify the `monodepth_main.py` so that it saves the disparity maps as numpy (.npy) files in one folder (per sequence)
3. Set the image and depth directories in `rpg_svo/svo_ros/param/vo_kitti.yaml`

**NOTE:** For saving disparity map, the naming convention is `depth_x.npy`, where x is 0-based with no leading zero.

#### Instructions
1. Clone this repo
```
cd ~/catkin_ws/src
git clone https://github.com/yan99033/CNN-VO
```

2. (OPTIONAL) Clone [monodepth-cpp repo](https://github.com/yan99033/monodepth-cpp)
```
cd ~/catkin_ws/src/CNN-VO
git clone https://github.com/yan99033/monodepth-cpp
```

2. Enable/disable [Online mode](#online-mode) by toggling **TRUE/FALSE** in `svo_ros/CMakeLists.txt` and `svo/CMakeLists.txt`. Also, make sure that Monodepth library and header file are linked properly if [Online mode](#online-mode) is used. Note that [Online mode](#online-mode) is disabled by default

3. Compile the project
```
cd ~/catkin_ws
catkin_make
```

4. Launch the project
```
roscore
rosrun rviz rviz -d ~/catkin_ws/src/CNN-VO/rpg_svo/svo_ros/rviz_kitti.rviz
roslaunch svo_ros kittiOffline00-02.launch
```

5. Try another KITTI sequence
  * Set the folder image and depth directories in `rpg_svo/svo_ros/param/vo_kitti.yaml`
  * Use the corresponding roslaunch file
  
#### Evaluation
We used ATE evaluation code provided by ORBSLAM [here](https://github.com/raulmur/evaluate_ate_scale) with a little bit of modification.


```
cd eval
```
```
python2 evaluate_ate_scale.py PATH_TO_GROUNDTRUTH PATH_TO_YOUR_OUTPUT PATH_TO_TIMESTAMPS_FILE --plot PATH_TO_PLOT_FILE_YOU_WANT_TO_SAVE
```
As an example:
```
python2 evaluate_ate_scale.py ground_truth/kitti_ground_truth/00.txt sample/seq00_CNN_SVO_KITTI_SAMPLE.txt ground_truth/kitti_ground_truth/00_times.txt --plot 00.png
```

#### Possible extension
We tried our best to improve the existing SVO, but this code is by no means perfect. That being said, we would like to point out some of the noticeable problems in our code:
1. The original SVO is not designed to handle too many keyframes (KFs). Therefore, the system begins to slow down after accumulating too much KFs. For example, the system is running smoothly on Oxford Robotcar dataset because of the high frame-per-second (16 FPS); in contrast, it doesn't handle a large amount of KFs well on KITTI dataset (10 FPS). (It is always better to use a high FPS camera)
2. As mentioned in the paper, we use a constant velocity model to handle extreme brightness condition (i.e., complete blank image), and then we back-project more points when new features can be observed. In practice, that makes sense for outdoor driving conditions. However, if your application requires proper relocalization, you would need to implement that by yourself.
3. The network is trained to process depth maps with the image size of 256x512x3. There are two image resizing steps (downsizing the image and upsizing the depth map) in the VO pipeline. Although we don't see any noticeable problem doing it, it is indeed faster to process the images with the size of 256x512x3.
4. It is a rather inefficient way to save and load the depth maps that are stored separately (i.e., depth_0.npy, depth_1, npy, ...). A better way to store and retrieve the depth maps in the [Offline mode](#offline-mode) is to save just ONE npy file (depth.npy) that has a shape of [total_num_images, width, height, 1]. 
5. (Suggestion) It would be better to create another thread for the visualization. The current approach to visualization is that it publishes local map points, trajectory and camera frustum, and those markers stay permanent until you close the visualization (unless the delete marker operation is carried out). You can have a dedicated thread (like ORB-SLAM) that gets all the keyframes and publishes the poses, map points and trajectory.

We hope that you can further extend the functionality of this work, and make the existing SVO even better (which is an impressive piece of work).

#### Disclaimer

The authors take no credit from [SVO](https://github.com/uzh-rpg/rpg_svo) and [Monodepth](https://github.com/mrharicot/monodepth). Therefore the licenses should remain intact. Please cite their work if you find them helpful.
