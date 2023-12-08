# FIXME: Makes a huge image.
# TODO: Optimize with a multi-stage build, perhaps also using venv.

# Pin to 3.10-bookworm to get Python 3.10, because https://github.com/MahmoudAshraf97/whisper-diarization/issues/90
FROM python:3.10-bookworm

ARG WD_USER
ARG WD_UID
ARG WD_GROUP
ARG WD_GID

# We rarely see a full upgrade in a Dockerfile. Why?
# && apt-get --assume-yes dist-upgrade \
RUN apt-get update \
  && apt-get --assume-yes --no-install-recommends install \
  cython3 \
  ffmpeg \
  unzip \
  wget \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY . .

RUN addgroup --gid $WD_GID $WD_GROUP \
  && adduser --uid $WD_UID --gid $WD_GID --shell /bin/bash --no-create-home $WD_USER \
  && chown -R $WD_USER:$WD_GROUP /usr/src/app

USER $WD_USER:$WD_GROUP

RUN mkdir venv \
  && python -m venv venv \
  && . venv/bin/activate \
  && pip install Cython \
  && pip install --no-cache-dir --requirement requirements.txt
