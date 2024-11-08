# pepperell_lab_STAR_RSEM_Pipeline
Normalized count from the pipeline: Fastqc-Trim-Fastqc-STAR-RSEM

## Pipeline Visualization
![Pipeline Made by Kadee](./RNAseq_CHTC_Pipelines.png )

## Build STAR/RSEM Dockerfile
To create and build Docker images for STAR and RSEM, follow these steps. For more details, refer to the [CHTC Docker Build Guide](https://chtc.cs.wisc.edu/uw-research-computing/docker-build.html). Replace `<username>`, `<imagename>`, and `<tag>` with your DockerHub username, image name, and desired tag, respectively.

### Steps
1. **Create the Dockerfiles**  
   Create separate Dockerfiles for RSEM and STAR:
   - `RSEM.Dockerfile`
   - `STAR.Dockerfile`
2. **Build the Docker Images**  
   Use `docker buildx` to build the images with the appropriate platform.

   ```bash
   docker buildx build . -f RSEM.Dockerfile -t <username>/<imagename> --platform linux/x86_64
   # Example:
   docker buildx build . -f RSEM.Dockerfile -t marissazhang/rsem --platform linux/x86_64

   docker buildx build . -f STAR.Dockerfile -t <username>/<imagename> --platform linux/x86_64
   # Example:
   docker buildx build . -f STAR.Dockerfile -t marissazhang/star --platform linux/x86_64
   ```
3. **Push the Docker Images**

   ```bash
   docker push <username>/<imagename>:<tag>
   # Example:
   docker push marissazhang/rsem:latest
   docker push marissazhang/star:latest
   ```
## Reference
https://link.springer.com/protocol/10.1007/978-1-4939-4035-6_14
