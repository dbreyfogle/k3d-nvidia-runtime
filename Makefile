IMAGE_REPOSITORY ?= dbreyfogle/k3d-nvidia-runtime
K3S_TAG ?= v1.29.6-k3s2
CUDA_TAG ?= 12.5.1-base-ubuntu24.04
IMAGE_TAG ?= $(K3S_TAG)-cuda-$(CUDA_TAG)

IMAGE := $(IMAGE_REPOSITORY):$(IMAGE_TAG)

.PHONY: all build push clean

all: build

build:
	docker build \
		--tag $(IMAGE) \
		--build-arg K3S_TAG=$(K3S_TAG) \
		--build-arg CUDA_TAG=$(CUDA_TAG) \
		.

push: build
	docker push $(IMAGE)

clean:
	docker rmi $(IMAGE)
