FROM nvcr.io/nvidia/cuda:11.7.1-base-ubuntu22.04
ENV DEBIAN_FRONTEND noninteractive


RUN apt-get update -y && apt-get upgrade -y && apt-get install -y libgl1 libglib2.0-0 wget curl htop git git-lfs python3-pip python-is-python3 python3-venv  && rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos '' machinelearning
RUN mkdir /content && chown -R machinelearning:machinelearning /content
WORKDIR /content
USER machinelearning

RUN pip install --upgrade pip xformers

RUN git clone  https://github.com/AUTOMATIC1111/stable-diffusion-webui
ADD --chown=machinelearning https://raw.githubusercontent.com/camenduru/stable-diffusion-webui-scripts/main/run_n_times.py /content/stable-diffusion-webui/scripts/run_n_times.py
RUN git clone https://github.com/deforum-art/deforum-for-automatic1111-webui /content/stable-diffusion-webui/extensions/deforum-for-automatic1111-webui
RUN git clone https://github.com/AlUlkesh/stable-diffusion-webui-images-browser /content/stable-diffusion-webui/extensions/stable-diffusion-webui-images-browser
RUN git clone https://github.com/camenduru/stable-diffusion-webui-huggingface /content/stable-diffusion-webui/extensions/stable-diffusion-webui-huggingface
RUN git clone https://github.com/Vetchems/sd-civitai-browser /content/stable-diffusion-webui/extensions/sd-civitai-browser
RUN git clone https://github.com/kohya-ss/sd-webui-additional-networks /content/stable-diffusion-webui/extensions/sd-webui-additional-networks
RUN git clone https://github.com/Mikubill/sd-webui-controlnet /content/stable-diffusion-webui/extensions/sd-webui-controlnet
RUN git clone https://github.com/camenduru/openpose-editor /content/stable-diffusion-webui/extensions/openpose-editor
RUN git clone https://github.com/jexom/sd-webui-depth-lib /content/stable-diffusion-webui/extensions/sd-webui-depth-lib
RUN git clone https://github.com/hnmr293/posex /content/stable-diffusion-webui/extensions/posex
RUN git clone https://github.com/camenduru/sd-webui-tunnels /content/stable-diffusion-webui/extensions/sd-webui-tunnels
RUN git clone https://github.com/etherealxx/batchlinks-webui /content/stable-diffusion-webui/extensions/batchlinks-webui
RUN git clone https://github.com/d8ahazard/sd_dreambooth_extension /content/stable-diffusion-webui/extensions/sd_dreambooth_extension
RUN git clone https://github.com/KohakuBlueleaf/a1111-sd-webui-locon /content/stable-diffusion-webui/extensions/a1111-sd-webui-locon
RUN cd stable-diffusion-webui && git reset --hard

ADD --chown=machinelearning https://huggingface.co/ckpt/ControlNet/resolve/main/control_canny-fp16.safetensors /content/stable-diffusion-webui/extensions/sd-webui-controlnet/models/control_canny-fp16.safetensors
ADD --chown=machinelearning https://huggingface.co/ckpt/ControlNet/resolve/main/control_depth-fp16.safetensors /content/stable-diffusion-webui/extensions/sd-webui-controlnet/models/control_depth-fp16.safetensors
ADD --chown=machinelearning https://huggingface.co/ckpt/ControlNet/resolve/main/control_hed-fp16.safetensors /content/stable-diffusion-webui/extensions/sd-webui-controlnet/models/control_hed-fp16.safetensors
ADD --chown=machinelearning https://huggingface.co/ckpt/ControlNet/resolve/main/control_mlsd-fp16.safetensors /content/stable-diffusion-webui/extensions/sd-webui-controlnet/models/control_mlsd-fp16.safetensors
ADD --chown=machinelearning https://huggingface.co/ckpt/ControlNet/resolve/main/control_normal-fp16.safetensors /content/stable-diffusion-webui/extensions/sd-webui-controlnet/models/control_normal-fp16.safetensors
ADD --chown=machinelearning https://huggingface.co/ckpt/ControlNet/resolve/main/control_openpose-fp16.safetensors /content/stable-diffusion-webui/extensions/sd-webui-controlnet/models/control_openpose-fp16.safetensors
ADD --chown=machinelearning https://huggingface.co/ckpt/ControlNet/resolve/main/control_scribble-fp16.safetensors /content/stable-diffusion-webui/extensions/sd-webui-controlnet/models/control_scribble-fp16.safetensors
ADD --chown=machinelearning https://huggingface.co/ckpt/ControlNet/resolve/main/control_seg-fp16.safetensors /content/stable-diffusion-webui/extensions/sd-webui-controlnet/models/control_seg-fp16.safetensors
ADD --chown=machinelearning https://huggingface.co/ckpt/ControlNet/resolve/main/hand_pose_model.pth /content/stable-diffusion-webui/extensions/sd-webui-controlnet/annotator/openpose/hand_pose_model.pth
ADD --chown=machinelearning https://huggingface.co/ckpt/ControlNet/resolve/main/body_pose_model.pth /content/stable-diffusion-webui/extensions/sd-webui-controlnet/annotator/openpose/body_pose_model.pth
ADD --chown=machinelearning https://huggingface.co/ckpt/ControlNet/resolve/main/dpt_hybrid-midas-501f0c75.pt /content/stable-diffusion-webui/extensions/sd-webui-controlnet/annotator/midas/dpt_hybrid-midas-501f0c75.pt
ADD --chown=machinelearning https://huggingface.co/ckpt/ControlNet/resolve/main/mlsd_large_512_fp32.pth /content/stable-diffusion-webui/extensions/sd-webui-controlnet/annotator/mlsd/mlsd_large_512_fp32.pth
ADD --chown=machinelearning https://huggingface.co/ckpt/ControlNet/resolve/main/mlsd_tiny_512_fp32.pth /content/stable-diffusion-webui/extensions/sd-webui-controlnet/annotator/mlsd/mlsd_tiny_512_fp32.pth
ADD --chown=machinelearning https://huggingface.co/ckpt/ControlNet/resolve/main/network-bsds500.pth /content/stable-diffusion-webui/extensions/sd-webui-controlnet/annotator/hed/network-bsds500.pth
ADD --chown=machinelearning https://huggingface.co/ckpt/ControlNet/resolve/main/upernet_global_small.pth /content/stable-diffusion-webui/extensions/sd-webui-controlnet/annotator/uniformer/upernet_global_small.pth
ADD --chown=machinelearning https://huggingface.co/ckpt/ControlNet/resolve/main/t2iadapter_style_sd14v1.pth /content/stable-diffusion-webui/extensions/sd-webui-controlnet/models/t2iadapter_style_sd14v1.pth
ADD --chown=machinelearning https://huggingface.co/ckpt/ControlNet/resolve/main/t2iadapter_sketch_sd14v1.pth /content/stable-diffusion-webui/extensions/sd-webui-controlnet/models/t2iadapter_sketch_sd14v1.pth
ADD --chown=machinelearning https://huggingface.co/ckpt/ControlNet/resolve/main/t2iadapter_seg_sd14v1.pth /content/stable-diffusion-webui/extensions/sd-webui-controlnet/models/t2iadapter_seg_sd14v1.pth
ADD --chown=machinelearning https://huggingface.co/ckpt/ControlNet/resolve/main/t2iadapter_openpose_sd14v1.pth /content/stable-diffusion-webui/extensions/sd-webui-controlnet/models/t2iadapter_openpose_sd14v1.pth
ADD --chown=machinelearning https://huggingface.co/ckpt/ControlNet/resolve/main/t2iadapter_keypose_sd14v1.pth /content/stable-diffusion-webui/extensions/sd-webui-controlnet/models/t2iadapter_keypose_sd14v1.pth
ADD --chown=machinelearning https://huggingface.co/ckpt/ControlNet/resolve/main/t2iadapter_depth_sd14v1.pth /content/stable-diffusion-webui/extensions/sd-webui-controlnet/models/t2iadapter_depth_sd14v1.pth
ADD --chown=machinelearning https://huggingface.co/ckpt/ControlNet/resolve/main/t2iadapter_color_sd14v1.pth /content/stable-diffusion-webui/extensions/sd-webui-controlnet/models/t2iadapter_color_sd14v1.pth
ADD --chown=machinelearning https://huggingface.co/ckpt/ControlNet/resolve/main/t2iadapter_canny_sd14v1.pth /content/stable-diffusion-webui/extensions/sd-webui-controlnet/models/t2iadapter_canny_sd14v1.pth

RUN sed -i -e '''/    prepare_environment()/a\    os.system\(f\"""sed -i -e ''\"s/dict()))/dict())).cuda()/g\"'' /content/stable-diffusion-webui/repositories/stable-diffusion-stability-ai/ldm/util.py""")''' /content/stable-diffusion-webui/launch.py
RUN sed -i -e 's/    start()/    #start()/g' /content/stable-diffusion-webui/launch.py
# RUN cd stable-diffusion-webui && python launch.py --skip-torch-cuda-test

ADD --chown=machinelearning https://huggingface.co/ckpt/sd15/resolve/main/v1-5-pruned-emaonly.ckpt /content/stable-diffusion-webui/models/Stable-diffusion/v1-5-pruned-emaonly.ckpt


EXPOSE 7860

CMD cd /content/stable-diffusion-webui && python webui.py --administrator --xformers  --update-all-extensions