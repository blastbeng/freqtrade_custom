ARG sourceimage=freqtradeorg/freqtrade
ARG sourcetag=develop_freqai
FROM ${sourceimage}:${sourcetag}

COPY ./freqtrade-git/requirements-freqai.txt ./freqtrade-git/requirements-freqai-rl.txt /freqtrade/

RUN pip install -r requirements-freqai-rl.txt --user 

RUN pip install --user --no-cache-dir tensorflow PyWavelets torch darts multiprocess finta tqdm keras

RUN pip install --user setuptools setuptools_rust

RUN pip uninstall -y polars

RUN curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf >> rustup-install.sh
RUN chmod +x rustup-install.sh
RUN ./rustup-install.sh -y

USER root

RUN apt install -y build-essential cmake

USER ftuser

RUN export PATH="/home/ftuser/.cargo/bin:$PATH"; pip3 install --user --force-reinstall --ignore-installed --no-binary :all: polars