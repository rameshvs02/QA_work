#!/bin/bash
# linkbench perf run

WORKDIR=$1
LINKBENCH_BASE=${PWD}

OUTDIR=${PWD}/res001
mkdir -p $OUTDIR

PIDS=()
iostat -dmx 10 >> $OUTDIR/iostat.res &
PIDS+=($!) 
dstat -t -v --nocolor 10 > $OUTDIR/dstat_plain.res  &
PIDS+=($!) 

export threadCountList="0001 0002 0004 0008 0016 0032 0064 0128 0256 0512 1024 2048"
for num_threads in ${threadCountList}; do
  $LINKBENCH_BASE/bin/linkbench  -D requesters=$num_threads -D maxid1=100000001 -c config/LinkConfigMysql.properties -csvstats $OUTDIR/final_stats_$num_threads.csv -csvstream $OUTDIR/streaming_stats_$num_threads.csv -D requests=5000000 -D maxtime=1800 -r > $OUTDIR/linkbench_run_$num_threads.log 2>&1
done

echo "Killing stats"
for var in "${PIDS[@]}"
do
  kill -9 $var
done
