# Env config
export KMP_BLOCKTIME=INF
export KMP_TPAUSE=0
export KMP_SETTINGS=1
export KMP_AFFINITY=granularity=fine,compact,1,0
export KMP_FORJOIN_BARRIER_PATTERN=dist,dist
export KMP_PLAIN_BARRIER_PATTERN=dist,dist
export KMP_REDUCTION_BARRIER_PATTERN=dist,dist
# IOMP & TcMalloc
export LD_PRELOAD=/root/anaconda3/envs/llm/lib/libiomp5.so:/root/anaconda3/envs/llm/lib/libtcmalloc.so:${LD_PRELOAD}
export CORES=$(lscpu | grep "Core(s) per socket" | awk '{print $NF}')

# Run GPT-j workload
OMP_NUM_THREADS=${CORES} numactl -N 0 -m 0 python run_gptj.py --ipex --jit --dtype bfloat16 --max-new-tokens 32
echo 3 > /proc/sys/vm/drop_caches
