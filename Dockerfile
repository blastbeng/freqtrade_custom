ARG sourceimage=freqtradeorg/freqtrade
ARG sourcetag=develop_freqai
FROM ${sourceimage}:${sourcetag}

COPY ./freqtrade-git/requirements-freqai.txt ./freqtrade-git/requirements-freqai-rl.txt /freqtrade/

RUN pip install -r requirements-freqai-rl.txt --user --no-cache-dir

RUN pip install tensorflow PyWavelets torch darts multiprocess finta tqdm keras
