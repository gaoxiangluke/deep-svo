#！/bin/bash
NUM=$1
echo "adabins"
echo $NUM
#export groud_truth=./ground_truth/kitti_ground_truth/_$(NUM).txt 
python2 evaluate_ate_scale.py ./ground_truth/kitti_ground_truth/$NUM.txt ./result/adabins_$NUM.txt ./ground_truth/kitti_ground_truth/$NUM\_times.txt --plot ./$NUM.png --verbose --save ./adabins_plot.data
echo "monodepth"
python2 evaluate_ate_scale.py ./ground_truth/kitti_ground_truth/$NUM.txt ./result/monodepth_$NUM.txt ./ground_truth/kitti_ground_truth/$NUM\_times.txt --plot ./$NUM.png --verbose --save ./monodepth_plot.data
echo "midas"
python2 evaluate_ate_scale.py ./ground_truth/kitti_ground_truth/$NUM.txt ./result/midas_$NUM.txt ./ground_truth/kitti_ground_truth/$NUM\_times.txt --plot ./$NUM.png --verbose --save ./midas_plot.data
echo "orb"
python2 evaluate_ate_scale.py ./ground_truth/kitti_ground_truth/$NUM.txt ./result/orbslam$NUM.txt ./ground_truth/kitti_ground_truth/$NUM\_times.txt --plot ./$NUM.png --verbose --save ./orb_plot.data
echo "orb_v2"
python2 evaluate_ate_scale.py ./ground_truth/kitti_ground_truth/$NUM.txt ./result/orbslam_v2$NUM.txt ./ground_truth/kitti_ground_truth/$NUM\_times.txt --plot ./$NUM.png --verbose --save ./orb_plotv2.data


