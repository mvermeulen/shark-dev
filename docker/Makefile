# Makefile approach to keeping docker dependencies built and up to date.
#
all:	tags/rocm-6.0 tags/rocm-5.7

tags/rocm-6.0: rocm-dev
	docker build --no-cache -f rocm-dev -t rocm:6.0 .
	touch tags/rocm-6.0

tags/rocm-5.7: rocm-dev
	docker build --no-cache -f rocm-dev -t rocm:5.7 \
	--build-arg install_script="https://repo.radeon.com/amdgpu_install/5.7.1/ubuntu/jammy/amdgpu-install_5.7.50701-1_all.deb" \
	--build-arg vulkan=amdvlk .
	touch tags/rocm-5.7

tags/shark-6.0: tags/rocm-6.0 shark-dev
	docker build --no-cache -f shark-dev -t shark:6.0 \
	--build-arg base_docker=rocm:6.0 .
	touch tags/shark-6.0

tags/shark-5.7: tags/rocm-5.7 shark-dev
	docker build --no-cache -f shark-dev -t shark:5.7 \
	--build-arg base_docker=shark:5.7 .
	touch tags/shark-5.7

tags/migraphx-6.0: tags/rocm-6.0 migraphx-dev
	docker build --no-cache -f migraphx-dev -t migraphx:6.0 \
	--build-arg base_docker=migraphx:6.0 .
	touch tags/migraphx-6.0

tags/migraphx-5.7: tags/rocm-5.7 migraphx-dev
	docker build --no-cache -f migraphx-dev -t migraphx:5.7 \
	--build-arg base_docker=migraphx:5.7 .
	touch tags/migraphx-5.7

tags/ort-migraphx-6.0: tags/migraphx-6.0 ort-migraphx-dev
	docker build --no-cache -f ort-migraphx-dev -t ort-migraphx:6.0 \
	--build-arg base_docker=migraphx:6.0 .
	touch tags/ort-migraphx-6.0

tags/ort-migraphx-5.7: tags/migraphx-5.7 ort-migraphx-dev
	docker build --no-cache -f ort-migraphx-dev -t ort-migraphx:5.7 \
	--build-arg base_docker=migraphx:5.7 .
	touch tags/ort-migraphx-5.7



