#!/bin/bash
# linkbench data load

WORKDIR=$1
LINKBENCH_BASE=${PWD}

OUTDIR=${PWD}/res001
mkdir -p $OUTDIR

$LINKBENCH_BASE/bin/linkbench -D maxid1=100000001 -c config/LinkConfigMysql.properties -l > $OUTDIR/linkbench_load.log 2>&1

