#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

WD_USER=adamm
WD_UID=1000
WD_GROUP=adamm
WD_GID=1000

docker build \
    --tag whisper-diarization \
    --build-arg WD_USER="$WD_USER" \
    --build-arg WD_UID="$WD_UID" \
    --build-arg WD_GROUP="$WD_GROUP" \
    --build-arg WD_GID="$WD_GID" \
    .
