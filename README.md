# freqtrade
Requirements:
    systemd enabled distro.
    clone this repo in /opt/docker/compose/freqtrade, else you'll need to edit docker-compose@.service.


I made this repo to make freqtrade works on my old UDOO X86, which doesn't support AVX instructions.
Also polar wasn't working so I removed it from the Docker image.

To make this work you need to build tensorflow by yourself and place it in the root dir of this project.
Then rename the tensorflow wheel filename inside the root Dockerfile.

To build tensorflow follow this guide: https://www.tensorflow.org/install/source?hl=it




If you have a CPU that supports AVX just use the docker compose file "docker-compose.tf_included.yml"



STEPS TO COMPILE TF 2.1.5

    docker run -it -w /tensorflow_src -v $PWD:/mnt -e HOST_PERMS="$(id -u):$(id -g)" tensorflow/tensorflow:devel bash
    
    wget https://apt.llvm.org/llvm.sh && chmod u+x llvm.sh && ./llvm.sh 16 && git pull && git fetch --all --tags && git checkout tags/v2.15.0 -b v2.15.0-branch
    
    ./configure
    
    bazel build --config=opt //tensorflow/tools/pip_package:build_pip_package
