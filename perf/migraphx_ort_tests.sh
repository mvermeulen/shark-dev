#!/bin/bash
set -x
ORT_REPO=${ORT_REPO:="/src/onnxruntime"}
TEST_RESULTS=${TEST_RESULTS:="/workdir/test_results"}
DATESTAMP=`date '+%Y%m%d-%H%M'`

testdir=${TEST_RESULTS}/$DATESTAMP
mkdir -p $testdir
cd $testdir

testscriptdir=${ORT_REPO}/onnxruntime/python/tools/transformers

rocm_options="-g -e onnxruntime --provider rocm"
cuda_options="-g -e onnxruntime --provider cuda"
migraphx_options="-g -e onnxruntime --provider migraphx --disable_gelu --disable_layer_norm --disable_attention --disable_skip_layer_norm --disable_embed_layer_norm --disable_bias_skip_layer_norm --disable_bias_gelu"
cpu_options="-e onnxruntime --provider cpu"
torch_options="-g -o no_opt -e torch"
torch2_options="-g -o no_opt -e torch2"
torchscript_options="-g -o no_opt -e torchscript"
tensorflow_options="-g -o no_opt -e tensorflow"

if [ -d /opt/rocm ]; then
    ENGINES=('rocm' 'migraphx' 'cpu' 'torch' 'torch2' 'torchscript' 'tensorflow')
    ENGINE_OPTIONS=(
	"$rocm_options"
	"$migraphx_options"
	"$cpu_options"
	"$torch_options"
	"$torch2_options"
	"$torchscript_options"
	"$tensorflow_options")
elif [ -d /usr/local/cuda ]; then
    ENGINES=('cuda' 'cpu' 'torch' 'torch2' 'torchscript' 'tensorflow')
    ENGINE_OPTIONS=(
	"$cuda_options"
	"$cpu_options"
	"$torch_options"
	"$torch2_options"
	"$torchscript_options"
	"$tensorflow_options")    
fi

while read model batch sequence precision
do
    for index in "${!ENGINES[@]}"
    do
	
	engine=${ENGINES[$index]}
	options=${ENGINE_OPTIONS[$index]}
	echo "*** python3 benchmark.py $options -m $model --batch_sizes $batch --sequence_length $sequence -p $precision"
	python3 $testscriptdir/benchmark.py $options -m $model --batch_sizes $batch --sequence_length $sequence -p $precision --result_csv summary.csv --detail_csv detail.csv 1>>${engine}.out 2>>${engine}.err
    done
done <<TESTCONFIG
bert-base-cased 1 32 fp16
bert-base-cased 1 384 fp16
bert-base-cased 32 32 fp16
bert-base-cased 32 384 fp16
bert-large-uncased 1 32 fp16
bert-large-uncased 1 384 fp16
bert-large-uncased 32 32 fp16
bert-large-uncased 32 384 fp16
distilgpt2 1 32 fp16
distilgpt2 1 384 fp16
distilgpt2 32 32 fp16
distilgpt2 32 384 fp16
TESTCONFIG
