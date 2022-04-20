# deep-svo
Github repository for Group 26 Rob530 project : Alternative Depth Estimation for Semi-direct Visual Odometry
Presentation available at https://www.youtube.com/watch?v=jEEdggdAqn8&feature=youtu.be
Our report available at report folder of this repository
## Abstract
Having reliable feature correspondences between frames is one crucial factor on any successful visual simultaneous localization and mapping (V-SLAM). Semi-direct visual odometry (SVO)\cite{svo} is a popular V-SLAM algorithm which combines direct and indirect methods to solve structure and motion. One major disadvantage for SVO is the initialization of map points. Without any depth estimation, the large depth uncertainty in initialization can lead to erroneous feature correspondence along the process. Fortunately, using a single-image depth prediction when initializing SVO can improve the effectiveness of feature matching and speed of depth convergence. It is proven by CNN-SVO\cite{CNN_SVO}. However, the monocular depth estimation from CNN is outdated. There are many other depth estimation packages have been proven to be more accurate such as "Mixing datasets for zero-shot corss-dataset transfer \cite{MiDas}(MiDas). In this project, we applied some modern depth prediction models to initialize the depth information at a feature location to improve the CNN-SVO mapping. We evaluate our method with
the popular outdoor benchmark: KITTI dataset.
## Open Source software
SVO https://github.com/uzh-rpg/rpg_svo
CNN-SVO https://github.com/yan99033/CNN-SVO
Monodepth2 https://github.com/nianticlabs/monodepth2
Midas https://github.com/isl-org/MiDaS
Adabins https://github.com/shariqfarooq123/AdaBins