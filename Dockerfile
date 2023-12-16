ARG sourceimage=freqtradeorg/freqtrade
ARG sourcetag=develop_freqai
FROM ${sourceimage}:${sourcetag}

COPY ./freqtrade-git/requirements-freqai.txt ./freqtrade-git/requirements-freqai-rl.txt /freqtrade/

RUN pip install -r requirements-freqai-rl.txt --user 

USER root

COPY tensorflow-2.16.0-cp311-cp311-linux_x86_64.whl /freqtrade/

RUN chown ftuser:ftuser /freqtrade/tensorflow-2.16.0-cp311-cp311-linux_x86_64.whl

USER ftuser

RUN pip install --user tensorflow-2.16.0-cp311-cp311-linux_x86_64.whl

RUN pip install --user PyWavelets darts multiprocess finta statsforecast prettytable

RUN pip uninstall -y polars