FROM nvcr.io/nvidia/cuda:11.7.1-base-ubuntu22.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y libgl1 libglib2.0-0 wget curl htop git git-lfs python3-pip python-is-python3 python3-venv  && rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos '' machinelearning && \
    mkdir /content && chown -R machinelearning:machinelearning /content

WORKDIR /content
USER machinelearning

RUN pip install torch --extra-index-url https://download.pytorch.org/whl/cu113 && \
    pip install transformers==4.19.2 diffusers invisible-watermark --prefer-binary && \
    pip install git+https://github.com/crowsonkb/k-diffusion.git git+https://github.com/TencentARC/GFPGAN.git --prefer-binary && \
    pip install --upgrade pip xformers

RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui

ARG scripts=https://raw.githubusercontent.com/camenduru/stable-diffusion-webui-scripts/main/run_n_times.py
ADD --chown=machinelearning $scripts /content/stable-diffusion-webui/scripts/run_n_times.py

ARG EXTENSIONS="deforum-art/deforum-for-automatic1111-webui AUTOMATIC1111/stable-diffusion-webui-rembg AlUlkesh/stable-diffusion-webui-images-browser camenduru/stable-diffusion-webui-huggingface Vetchems/sd-civitai-browser kohya-ss/sd-webui-additional-networks Mikubill/sd-webui-controlnet camenduru/openpose-editor jexom/sd-webui-depth-lib hnmr293/posex camenduru/sd-webui-tunnels etherealxx/batchlinks-webui d8ahazard/sd_dreambooth_extension KohakuBlueleaf/a1111-sd-webui-locon"

RUN for repository in $EXTENSIONS ; do \
    git clone https://github.com/$repository /content/stable-diffusion-webui/extensions/$(basename $repository) ; \
    done

WORKDIR /content/stable-diffusion-webui

RUN git reset --hard

EXPOSE 7860

RUN wget -qO- https://raw.githubusercontent.com/AUTOMATIC1111/stable-diffusion-webui/master/webui.sh -P /content/stable-diffusion-webui

CMD ["./webui.sh", "--administrator", "--xformers", "--update-all-extensions", "--update-check"]