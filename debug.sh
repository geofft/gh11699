set -e

# date > cache-bust.txt
docker build --platform="linux/arm64/v8" --tag gh11699:latest --load .

echo "Running"

docker run --cap-add=SYS_PTRACE --security-opt seccomp=unconfined --rm -it --platform linux/arm64/v8 \
  -v $(pwd)/cache-uv:/root/.cache/uv \
  -v $(pwd)/uv-aarch64:/root/uv-aarch64 \
  --net host \
  gh11699:latest \
  gdbserver :7777 /root/uv-aarch64 pip install anyio
