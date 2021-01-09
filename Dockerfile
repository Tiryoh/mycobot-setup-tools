# (C) 2021 Daisuke Sato
# SPDX-License-Identifier: MIT
FROM python:3.6.12-slim-buster
LABEL maintainer="tiryoh@gmail.com"
RUN pip3 install pyserial ipython
COPY elephantrobotics-mycobot/API/Python /work/python-mycobot
RUN cd /work/python-mycobot && python3 setup.py install
ENTRYPOINT ["ipython"]
