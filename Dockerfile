ARG sourceimage=freqtradeorg/freqtrade
ARG sourcetag=develop_freqai
FROM ${sourceimage}:${sourcetag}

RUN pip install tensorflow PyWavelets torch darts multiprocess finta tqdm keras