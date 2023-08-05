FROM nvcr.io/nvidia/cuda:11.7.1-base-ubuntu22.04

RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    python3-venv \
    libgl1-mesa-glx \
    libglib2.0-0

RUN pip3 install torch --extra-index-url https://download.pytorch.org/whl/cu113

RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git

WORKDIR /stable-diffusion-webui

RUN mkdir repositories && \
    git clone https://github.com/CompVis/stable-diffusion.git repositories/stable-diffusion-stability-ai && \
    git clone https://github.com/CompVis/taming-transformers.git repositories/taming-transformers && \
    git clone https://github.com/sczhou/CodeFormer.git repositories/CodeFormer && \
    git clone https://github.com/salesforce/BLIP.git repositories/BLIP

RUN pip3 install --upgrade pip setuptools pytorch-lightning && \
    pip3 install transformers==4.19.2 diffusers invisible-watermark --prefer-binary && \
    pip3 install git+https://github.com/crowsonkb/k-diffusion.git --prefer-binary && \
    pip3 install git+https://github.com/TencentARC/GFPGAN.git --prefer-binary && \
    pip3 install -r repositories/CodeFormer/requirements.txt --prefer-binary && \
    pip3 install -r requirements.txt  --prefer-binary && \
    pip3 install -U numpy  --prefer-binary

CMD ["python3", "webui.py"]