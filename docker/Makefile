# Makefile approach to keeping docker dependencies built and up to date.
#
all:	tags/ort-migraphx-6.0 tags/ort-migraphx-5.7

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
