ARG sourceimage=freqtradeorg/freqtrade
ARG sourcetag=develop_freqai
FROM ${sourceimage}:${sourcetag}

COPY ./freqtrade-git/requirements-freqai.txt ./freqtrade-git/requirements-freqai-rl.txt /freqtrade/

RUN pip install -r requirements-freqai-rl.txt --user 

RUN pip install --user --no-cache-dir tensorflow PyWavelets torch darts multiprocess finta tqdm keras

RUN pip uninstall -y polars

RUN curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf >> rustup-install.sh
RUN chmod +x rustup-install.sh
RUN ./rustup-install.sh -y
RUN . "$HOME/.cargo/env"

RUN mkdir "/$HOME/tmpbuild"

ENV TMPDIR="/$HOME/tmpbuild"

ENV PATH="$HOME/.cargo/bin:$PATH"

RUN pip install --user wheel setuptools setuptools_rust
RUN pip install --user --force-reinstall --ignore-installed --no-binary :all: polars

RUN rm -rf "/$HOME/tmpbuild"