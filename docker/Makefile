# Makefile approach to keeping docker dependencies built and up to date.
#
all:	rocm

rocm:	tags/ort-migraphx-6.0 tags/ort-migraphx-5.7 tags/shark-5.7 tags/shark-6.0

cuda:	tags/shark-cuda-12.2 tags/ort-cuda-11.8 tags/ort-tensorrt-12.3 tags/cuda-tvm-12.2

tags/rocm-6.0: rocm-dev
	docker build --no-cache -f rocm-dev -t rocm:6.0 . 2>&1 | tee logs/rocm-6.0.txt
	./check_docker.sh rocm:6.0 tags/rocm-6.0

tags/rocm-5.7: rocm-dev
	docker build --no-cache -f rocm-dev -t rocm:5.7 \
        --build-arg install_script="https://repo.radeon.com/amdgpu-install/5.7.1/ubuntu/jammy/amdgpu-install_5.7.50701-1_all.deb" \
	--build-arg vulkan="--vulkan=pro" . 2>&1 | tee logs/rocm-5.7.txt
	./check_docker.sh rocm:5.7 tags/rocm-5.7

tags/shark-6.0: tags/rocm-6.0 shark-dev
	docker build --no-cache -f shark-dev -t shark:6.0 \
	--build-arg base_docker=rocm:6.0 . 2>&1 | tee logs/shark-6.0.txt
	./check_docker.sh shark:6.0 tags/shark-6.0

tags/shark-5.7: tags/rocm-5.7 shark-dev
	docker build --no-cache -f shark-dev -t shark:5.7 \
	--build-arg base_docker=rocm:5.7 . 2>&1 | tee logs/shark-5.7.txt
	./check_docker.sh shark:5.7 tags/shark-5.7

tags/migraphx-6.0: tags/rocm-6.0 migraphx-dev
	docker build --no-cache -f migraphx-dev -t migraphx:6.0 \
	--build-arg base_docker=rocm:6.0 . 2>&1 | tee logs/migraphx-6.0.txt
	./check_docker.sh migraphx:6.0 tags/migraphx-6.0

tags/migraphx-5.7: tags/rocm-5.7 migraphx-dev
	docker build --no-cache -f migraphx-dev -t migraphx:5.7 \
	--build-arg base_docker=rocm:5.7 . 2>&1 | tee logs/migraphx-5.7.txt
	./check_docker.sh migraphx:5.7 tags/migraphx-5.7

tags/ort-migraphx-6.0: tags/migraphx-6.0 ort-migraphx-dev
	docker build --no-cache -f ort-migraphx-dev -t ort-migraphx:6.0 \
	--build-arg base_docker=migraphx:6.0 . 2>&1 | tee logs/ort-migraphx-6.0.txt
	./check_docker.sh ort-migraphx:6.0 tags/ort-migraphx-6.0

tags/ort-migraphx-5.7: tags/migraphx-5.7 ort-migraphx-dev
	docker build --no-cache -f ort-migraphx-dev -t ort-migraphx:5.7 \
	--build-arg base_docker=migraphx:5.7 . 2>&1 | tee logs/ort-migraphx-5.7.txt
	./check_docker.sh ort-migraphx:5.7 tags/ort-migraphx-5.7

tags/cuda-12.2: cuda-dev
	docker build --no-cache -f cuda-dev -t cuda:12.2 \
        --build-arg base_docker="nvidia/cuda:12.2.2-cudnn8-devel-ubuntu22.04" \
	. 2>&1 | tee logs/cuda-12.2.txt
	./check_docker.sh cuda:12.2 tags/cuda-12.2

tags/cuda-11.8: cuda-dev
	docker build --no-cache -f cuda-dev -t cuda:11.8 \
	--build-arg base_docker="nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04" \
	. 2>&1 | tee logs/cuda-11.8.txt
	./check_docker.sh cuda:11.8 tags/cuda-11.8

tags/shark-cuda-12.2:	tags/cuda-12.2 shark-dev
	docker build --no-cache -f shark-dev -t shark:12.2 \
	--build-arg base_docker=cuda:12.2 . 2>&1 | tee logs/shark-cuda-12.2.txt
	./check_docker.sh shark:12.2 tags/shark-cuda-12.2

tags/shark-cuda-11.8:	tags/cuda-11.8 shark-dev
	docker build --no-cache -f shark-dev -t shark:11.8 \
	--build-arg base_docker=cuda:11.8 . 2>&1 | tee logs/shark-cuda-11.8.txt
	./check_docker.sh shark:11.8 tags/shark-cuda-11.8

tags/ort-cuda-12.2:	tags/cuda-12.2 ort-cuda-dev
	docker build --no-cache -f ort-cuda-dev -t ort-cuda:12.2 \
	--build-arg base_docker=cuda:12.2 . 2>&1 | tee logs/ort-cuda-12.2.txt
	./check_docker.sh ort-cuda:12.2 tags/ort-cuda-12.2

tags/ort-cuda-11.8:	tags/cuda-11.8 ort-cuda-dev
	docker build --no-cache -f ort-cuda-dev -t ort-cuda:11.8 \
	--build-arg base_docker=cuda:11.8 . 2>&1 | tee logs/ort-cuda-11.8.txt
	./check_docker.sh ort-cuda:11.8 tags/ort-cuda-11.8

tags/tensorrt-12.3: tensorrt-dev
	docker build --no-cache -f tensorrt-dev -t tensorrt:12.3 \
	--build-arg base_docker="nvcr.io/nvidia/tensorrt:23.12-py3" . 2>&1 | tee logs/ort-tensorrt-12.3.txt
	./check_docker.sh tensorrt:12.3 tags/tensorrt-12.3

tags/ort-tensorrt-12.3: tags/tensorrt-12.3 ort-cuda-dev
	docker build --no-cache -f ort-cuda-dev -t ort-tensorrt:12.3 \
	--build-arg base_docker=tensorrt:12.3 . 2>&1 | tee logs/ort-tensorrt-12.3.txt
	./check_docker.sh ort-tensorrt:12.3 tags/ort-tensorrt-12.3

tags/rocm-tvm-6.0:	tvm-dev scripts/build_tvm.sh
	docker build --no-cache -f tvm-dev -t rocm-tvm:6.0 \
	--build-arg base_docker=rocm:6.0 . 2>&1 | tee logs/rocm-tvm-6.0.txt
	./check_docker.sh rocm-tvm:6.0 tags/rocm-tvm-6.0

tags/cuda-tvm-12.2: tvm-dev tags/cuda-12.2
	docker build --no-cache -f tvm-dev -t cuda-tvm:12.2 \
	--build-arg base_docker=cuda:12.2 . 2>&1 | tee logs/cuda-tvm-12.2.txt
	./check_docker.sh cuda-tvm:12.2 tags/cuda-tvm-12.2
