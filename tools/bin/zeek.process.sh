#!/usr/bin/env bash

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "git could not be found"
    exit 1
fi

PROJECT_ROOT=`git rev-parse --show-toplevel`
ZEEK_DOCKER_IMAGE="zeekurity/zeek:latest"
ZEEK_DIR="data/ingest/zeek"
PCAP_DIR="data/ingest/pcap/"

# Fixes Github Action error, "tput: No value for $TERM and no -T specified",
# that occurs When $TERM is empty (non-interactive shell) by faking a value
# for the terminal profile.
[[ ${TERM}=="" ]] && export TERM='xterm-256color'


pushd $PROJECT_ROOT
    docker run                                \
      -it                                     \
      --entrypoint /bin/bash                  \
      --rm                                    \
      --volume data:/data:z                   \
      --workdir /data/zeek                    \
      $ZEEK_DOCKER_IMAGE


  # # Check if the zeek image is available locally. If not,
  # # pull the image from the docker registry.
  # if ! docker image inspect $ZEEK_DOCKER_IMAGE > /dev/null 2>&1; then
  #   echo "Zeek image not found. Pulling..."
  #   docker pull $ZEEK_DOCKER_IMAGE
  # fi

  # if [[ -z "${1}" ]]; then
  #   echo "No pcap file specified. Running Zeek on all pcaps in $PCAP_DIR"
  #   PCAP_FILES=`find $PCAP_DIR -type f -name "*.pcap"`
  #   for PCAP_FILE in $PCAP_FILES; do
  #     $0 $PCAP_FILE
  #   done
  # else
  #   PCAP_FILE=$1
  #   echo "Running Zeek on ${PCAP_FILE}"

  #   docker run                                \
  #     --rm                                    \
  #     --workdir /data/zeek                    \
  #     -v data:/data:z                         \
  #     --entrypoint /bin/bash \
  #     $ZEEK_DOCKER_IMAGE
  #     # zeek                                    \
  #     #   --no-checksums                        \
  #     #   --readfile /${PCAP_DIR}/${PCAP_FILE}  \
  #     #   LogAscii::use_json=T                  \
  #     #   local

  #     # mv \
  #     #   "${PROJECT_ROOT}/${PCAP_DIR}/${PCAP_FILE}" \
  #     #   "${PROJECT_ROOT}/${PCAP_DIR}/unprocessed_files/${PCAP_FILE}"

  # fi
popd



# NOTES:
#  - https://docs.zeek.org/en/master/install.html
#  - https://github.com/zeek/zeek/blob/master/docker/Dockerfile
#  - docker run --rm -it --entrypoint /bin/bash -v `pwd`:/app:z zeekurity/zeek:latest


