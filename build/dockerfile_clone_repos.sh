#!/bin/bash

REPOS=(
"https://github.com/deforum-art/deforum-for-automatic1111-webui"
"https://github.com/AlUlkesh/stable-diffusion-webui-images-browser"
"https://github.com/camenduru/stable-diffusion-webui-huggingface"
"https://github.com/Vetchems/sd-civitai-browser"
"https://github.com/kohya-ss/sd-webui-additional-networks"
"https://github.com/Mikubill/sd-webui-controlnet"
"https://github.com/camenduru/openpose-editor"
"https://github.com/jexom/sd-webui-depth-lib"
"https://github.com/hnmr293/posex"
"https://github.com/camenduru/sd-webui-tunnels"
"https://github.com/etherealxx/batchlinks-webui"
"https://github.com/d8ahazard/sd_dreambooth_extension"
"https://github.com/KohakuBlueleaf/a1111-sd-webui-locon")

for repo in ${REPOS[@]}; do
  git clone $repo
done