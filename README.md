# k3d-nvidia-runtime

This repository provides a custom Docker image which enables K3d to run CUDA containers. See the K3d documentation for more details: https://k3d.io/v5.6.3/usage/advanced/cuda.

## Create a Cluster

```bash
k3d cluster create \
    --image dbreyfogle/k3d-nvidia-runtime:v1.29.6-k3s2-cuda-12.5.1-base-ubuntu24.04 \
    --gpus all \
    gpu-cluster
```

Note: the version of K3s and CUDA must match the one you're planning to use.

## Run a Test Pod

```bash
kubectl apply -f cuda-vector-add.yaml
```

Once the status is completed, view the results:

```bash
kubectl logs cuda-vector-add
```

This should output something like the following:

```
[Vector addition of 50000 elements]
Copy input data from the host memory to the CUDA device
CUDA kernel launch with 196 blocks of 256 threads
Copy output data from the CUDA device to the host memory
Test PASSED
Done
```

Note: you must explicitly add `runtimeClassName: nvidia` to all your Pod specs to use the GPU. See the K3s documentation for more details: https://docs.k3s.io/advanced#nvidia-container-runtime-support.
