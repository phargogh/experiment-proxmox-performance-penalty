#!/bin/bash

set -ex

CPU_DIR="cpu-results"
mkdir "$CPU_DIR" || echo "$CPU_DIR/ already exists"
for i in {0..5}
do
    sysbench cpu > $CPU_DIR/cpu-$i.txt
done;

FILEIO_DIR="fileio-results"
mkdir $FILEIO_DIR || echo "$FILEIO_DIR/ already exists"
sysbench fileio prepare
for option in "seqwr seqrewr seqrd rndrd rndwr rndrw"
do
    for i in {0..5}
    do
        sysbench fileio run --file-test-mode=$option > $FILEIO_DIR/fileio-$option-$i.txt
    done
done
sysbench fileio cleanup

# run an InVEST model - scenic quality
wget https://storage.googleapis.com/releases.naturalcapitalproject.org/invest/3.14.1/data/ScenicQuality.zip
unzip ScenicQuality.zip
for i in {0..5}
do
    sudo docker run --rm -ti -v $(pwd):/natcap -w /natcap ghcr.io/natcap/devstack:latest python3 /natcap/test-sq.py /natcap/InVEST-sq-results/sq-workspace-$i
done

