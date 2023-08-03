FROM nvcr.io/nvidia/cuda:11.7.1-base-ubuntu22.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y libgl1 libglib2.0-0 wget curl htop git git-lfs python3-pip python-is-python3 python3-venv \
    && rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos '' machinelearning

RUN mkdir /content && chown -R machinelearning:machinelearning /content

WORKDIR /content

USER machinelearning

RUN python -m pip install --upgrade pip xformers fastapi uvicorn \
    && git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui \
    && cd stable-diffusion-webui \
    && python3 -m venv venv \
    && venv/bin/pip install -r requirements.txt

COPY --chown=machinelearning dockerfile_clone_repos.sh ./
COPY --chown=machinelearning dockerfile_add_files.sh ./

RUN chmod +x ./dockerfile_clone_repos.sh \
    && chmod +x ./dockerfile_add_files.sh \
    && ./dockerfile_clone_repos.sh \
    && ./dockerfile_add_files.sh \
    && rm dockerfile_clone_repos.sh dockerfile_add_files.sh

EXPOSE 7860
CMD cd stable-diffusion-webui && python webui.py --administrator --xformers  --update-all-extensions