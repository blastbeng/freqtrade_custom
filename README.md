# freqtrade
I made this repo to make freqtrade works on my old UDOO X86, which doesn't support AVX instructions.
Also polar wasn't working so I removed it from the Docker image.

To make this work you need to build tensorflow by yourself name it as tensorflow.whl and place it in the root dir of this project..

To build tensorflow follow this guide: https://www.tensorflow.org/install/source?hl=it




If you have a CPU that supports AVX just use the docker compose file "docker-compose.yml"
