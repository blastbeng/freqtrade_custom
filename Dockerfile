FROM python:3.10-bullseye

# Setup env
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONFAULTHANDLER 1
ENV PATH=/home/ftuser/.local/bin:$PATH
ENV FT_APP_ENV="docker"

# Prepare environment
RUN mkdir /freqtrade \
  && apt-get update \
  && apt-get -y install sudo libatlas3-base curl sqlite3 libhdf5-serial-dev libgomp1 build-essential libssl-dev git libffi-dev libgfortran5 pkg-config cmake gcc python3 python3-pip\
  && apt-get clean \
  && useradd -u 1000 -G sudo -U -m -s /bin/bash ftuser \
  && chown ftuser:ftuser /freqtrade \
  # Allow sudoers
  && echo "ftuser ALL=(ALL) NOPASSWD: /bin/chown" >> /etc/sudoers

WORKDIR /freqtrade


# Install TA-lib
COPY freqtrade-git/build_helpers/* /tmp/
RUN cd /tmp && /tmp/install_ta-lib.sh && rm -r /tmp/*ta-lib*
ENV LD_LIBRARY_PATH /usr/local/lib



# Install dependencies
COPY --chown=ftuser:ftuser freqtrade-git/requirements.txt freqtrade-git/requirements-hyperopt.txt /freqtrade/

USER ftuser

# Install dependencies
RUN pip install --upgrade pip wheel
RUN pip install --user --no-cache-dir numpy
RUN pip install --user --no-cache-dir -r requirements-hyperopt.txt

# Copy dependencies to runtime-image
#COPY --from=python-deps /usr/local/lib /usr/local/lib
#ENV LD_LIBRARY_PATH /usr/local/lib

#COPY --from=python-deps --chown=ftuser:ftuser /home/ftuser/.local /home/ftuser/.local

#USER ftuser
# Install and execute
COPY --chown=ftuser:ftuser freqtrade-git/. /freqtrade/

RUN pip install -e . --user --no-cache-dir --no-build-isolation \
  && mkdir /freqtrade/user_data/ \
  && freqtrade install-ui

COPY freqtrade-git/requirements-freqai.txt /freqtrade/

RUN pip install -r requirements-freqai.txt --user --no-cache-dir

COPY freqtrade-git/requirements-freqai-rl.txt /freqtrade/

RUN pip install -r requirements-freqai-rl.txt --user --no-cache-dir

COPY --chown=ftuser:ftuser tensorflow-2.15.0-cp310-cp310-linux_x86_64.whl /freqtrade/

COPY requirements-custom.txt /freqtrade/

RUN pip install -r requirements-custom.txt --user --no-cache-dir

RUN chown ftuser:ftuser /freqtrade/tensorflow-2.15.0-cp310-cp310-linux_x86_64.whl

RUN pip install --user tensorflow-2.15.0-cp310-cp310-linux_x86_64.whl

RUN pip uninstall -y polars

RUN pip install --user --no-cache-dir polars-lts-cpu

ENTRYPOINT ["freqtrade"]
# Default to trade mode
CMD [ "trade" ]
