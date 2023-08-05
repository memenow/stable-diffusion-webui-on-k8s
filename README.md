# stable-diffusion-webui-on-k8s

Stable Diffusion WebUI on k8s


## Prerequisites

- Nvidia GPU

- Default StorageClass

- [Helm CLI](https://github.com/helm/helm) 


## Setup

1. **Building the Container Image**
   Navigate to the build folder and build your Docker image using the Docker build command, replacing 'YOUR_IMAGE_NAME' with your desired Docker image name.

    ```bash
    cd ./build && docker build -t YOUR_IMAGE_NAME .
    ```

2. **Modifying the Helm value file**

   You'll have to adjust your Helm value file, particularly the image name.

3. **Installing the Helm Chart**

   Install the chart into your desired namespace (replace 'NAMESPACE' with your desired namespace)

    ```bash
    helm install -n NAMESPACE stable-diffusion-webui-on-k8s ./stable-diffusion-webui-on-k8s
    ```


## References

[stable-diffusion-webui](https://github.com/AUTOMATIC1111/stable-diffusion-webui)
