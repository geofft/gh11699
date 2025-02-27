set -e

# date > cache-bust.txt
docker build --platform="linux/arm64/v8" --tag gh11699:latest .

docker run --rm -it --platform linux/arm64/v8 \
  -v $(pwd)/cache-uv:/root/.cache/uv \
  -v $(pwd)/uv-aarch64:/root/uv-aarch64 \
  --net host \
  gh11699:latest \
  bash -c "/root/uv-aarch64 pip install anyio \
  && /root/uv-aarch64 pip install tqdm \
  && /root/uv-aarch64 pip install numpy \
  && /root/uv-aarch64 pip install plotly"

