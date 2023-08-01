#!/bin/bash

FILES=("https://huggingface.co/ckpt/ControlNet/resolve/main/control_canny-fp16.safetensors"
"https://huggingface.co/ckpt/ControlNet/resolve/main/control_depth-fp16.safetensors"
"https://huggingface.co/ckpt/ControlNet/resolve/main/control_hed-fp16.safetensors"
"https://huggingface.co/ckpt/ControlNet/resolve/main/control_mlsd-fp16.safetensors"
"https://huggingface.co/ckpt/ControlNet/resolve/main/control_normal-fp16.safetensors"
"https://huggingface.co/ckpt/ControlNet/resolve/main/control_openpose-fp16.safetensors"
"https://huggingface.co/ckpt/ControlNet/resolve/main/control_scribble-fp16.safetensors"
"https://huggingface.co/ckpt/ControlNet/resolve/main/control_seg-fp16.safetensors"
"https://huggingface.co/ckpt/ControlNet/resolve/main/hand_pose_model.pth"
"https://huggingface.co/ckpt/ControlNet/resolve/main/body_pose_model.pth"
"https://huggingface.co/ckpt/ControlNet/resolve/main/dpt_hybrid-midas-501f0c75.pt")

for file in ${FILES[@]}; do
  wget $file -P /content/stable-diffusion-webui/extensions/sd-webui-controlnet/models/
done