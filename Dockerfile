FROM ubuntu:24.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qy && apt-get install -qyy python3  python3-setuptools

RUN apt install -qyy gdbserver

COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

ENV UV_LINK_MODE=copy \
    UV_COMPILE_BYTECODE=1 \
    RUST_LOG="uv_installer::compile=trace"

RUN uv venv -p /usr/bin/python3.12

