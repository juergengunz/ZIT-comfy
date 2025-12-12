# Start from official RunPod ComfyUI worker base
FROM runpod/worker-comfyui:5.6.0-base

# Install base Python dependencies
RUN pip install --no-cache-dir \
    pillow>=10.3.0 \
    scipy \
    color-matcher \
    matplotlib \
    huggingface_hub \
    mss \
    opencv-python \
    scikit-image


RUN git clone --branch main https://github.com/juergengunz/load_lora_url_node /comfyui/custom_nodes/ComfyUI_LoRA_from_URL

RUN pip install --no-cache-dir -r /comfyui/custom_nodes/ComfyUI_LoRA_from_URL/requirements.txt

# Install registry nodes
RUN comfy-node-install comfyui-kjnodes rgthree-comfy 


# RUN pip install --no-cache-dir flash-attn triton


RUN comfy model download --url https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/text_encoders/qwen_3_4b.safetensors --relative-path models/text_encoders --filename qwen_3_4b.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/diffusion_models/z_image_turbo_bf16.safetensors --relative-path models/diffusion_models --filename z_image_turbo_bf16.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/vae/ae.safetensors --relative-path models/vae --filename ae.safetensors



