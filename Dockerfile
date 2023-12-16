ARG sourceimage=freqtradeorg/freqtrade
ARG sourcetag=develop_freqai
FROM ${sourceimage}:${sourcetag}

COPY ./freqtrade-git/requirements-freqai.txt ./freqtrade-git/requirements-freqai-rl.txt /freqtrade/

RUN pip install -r requirements-freqai-rl.txt --user 

USER root

COPY tensorflow.whl /freqtrade/

RUN chown ftuser:ftuser /freqtrade/tensorflow.whl

USER ftuser

RUN pip install --user tensorflow.whl

RUN pip install --user PyWavelets darts multiprocess finta statsforecast prettytable

RUN pip uninstall -y polars