#!/usr/bin/env bash

# Check if both git and docker are installed
if [[ ! -x "$(command -v docker)" ]]; then
  echo "Docker is not installed. Please install docker and try again."
  exit 1
fi
if [[ ! -x "$(command -v git)" ]]; then
  echo "Git is not installed. Please install git and try again."
  exit 1
fi


PROJECT_ROOT=`git rev-parse --show-toplevel`
ZEEK_DOCKER_IMAGE="zeekurity/zeek:latest"
ZEEK_DIR="data/ingest/zeek"
PCAP_DIR="data/ingest/pcap"

# Fixes Github Action error, "tput: No value for $TERM and no -T specified",
[[ ${TERM}=="" ]] && export TERM='xterm-256color'


# Check if the zeek image is available locally. If not,
# pull the image from the docker registry.
if ! docker image inspect $ZEEK_DOCKER_IMAGE > /dev/null 2>&1; then
  echo "Zeek image not found. Pulling..."
  docker pull $ZEEK_DOCKER_IMAGE
fi


if [[ -z "${1}" ]]; then
  echo "No pcap file specified. Running Zeek on all pcaps in $PCAP_DIR"
  PCAP_FILES=`find ${PCAP_DIR}/unprocessed_files -type f -name "*.pcap"`
  for PCAP_FILE in $PCAP_FILES; do
    $0 $PCAP_FILE
  done
else
  pushd $PROJECT_ROOT
    PCAP_FILE=$1
    FILENAME=`basename $PCAP_FILE`
    OUTPUT_DIR="${ZEEK_DIR}/`echo $FILENAME | sed 's/\.pcap$//g'`"

    echo "Processing ${FILENAME}..."

    if [[ -d $OUTPUT_DIR ]]; then
      echo "Output directory already exists. Skipping..."
    else
      echo "Running Zeek on ${PCAP_FILE}..."
      mkdir -p $OUTPUT_DIR
      docker run                     \
        --rm                         \
        --volume `pwd`/data:/data:z  \
        --workdir /$OUTPUT_DIR       \
        $ZEEK_DOCKER_IMAGE           \
        zeek                         \
          --no-checksums             \
          --readfile /${PCAP_FILE}   \
          LogAscii::use_json=T       \
          local

      mv $PCAP_FILE "${PCAP_DIR}/finished_pcaps/${FILENAME}"
    fi
  popd
fi


# NOTES:
#  - https://docs.zeek.org/en/master/install.html
#  - https://github.com/zeek/zeek/blob/master/docker/Dockerfile
