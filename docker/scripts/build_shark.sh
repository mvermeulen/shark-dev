#!/bin/bash
#
WORKDIR=${WORKDIR:="/workdir"}
SHARK_REPOSITORY=${SHARK_REPOSITORY:="https://github.com/nod-ai/SHARK"}
SHARK_BRANCH=${SHARK_BRANCH:="SHARK-1.0"}

# pull in SHARK
mkdir -p /src
cd /src
git clone --depth=1 --branch ${SHARK_BRANCH} ${SHARK_REPOSITORY} ${SHARK_BRANCH}
cd ${SHARK_BRANCH}
PYTHON=python3.11 ./setup_venv.sh
