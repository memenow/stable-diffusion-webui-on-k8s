FROM nvcr.io/nvidia/cuda:11.7.1-base-ubuntu22.04

RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-venv \
    libgl1-mesa-glx \
    libglib2.0-0

RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git

WORKDIR /stable-diffusion-webui

RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 7860

RUN cd stable-diffusion-webui && python launch.py --skip-torch-cuda-test

CMD ["python", "launch.py"]
