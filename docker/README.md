## 
This docker file sets up the environment for pytorch with cuda 11.1. It aims at installing all non-conflicting related softwares, and encourages download-and-run.


### How to build the docker image from `Dockerfile`?

To build the docker image, run `docker build --tag justintzuyuan/pytorch_1.8_cuda_11.1 . `

If you want to make any changes to this docker image, edit the `Dockerfile`. If any changes happends, remember to update the `LABEL version` inside. 

### How to run this docker container?
`bash run_contact_estimator_docker.bash [container_name]`. Change the home directly, disk volumn mapping in this bash file correspondingly.


### After the docker container is running 
`docker exec -it [container_name] /bin/bash` to use bash as user
`docker exec -u root -it [container_name] /bin/bash` to use bash as root
docker exec -u root -it cbed6d5d7309 /bin/bash
 