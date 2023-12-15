ARG sourceimage=freqtradeorg/freqtrade
ARG sourcetag=develop_freqai_rl
FROM ${sourceimage}:${sourcetag}

RUN pip install tensorflow PyWavelets torch darts multiprocess finta tqdm keras
