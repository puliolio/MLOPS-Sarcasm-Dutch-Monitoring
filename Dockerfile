FROM tensorflow/serving:latest

# Copy the model to the container
COPY ./output/serving_model/daffamh-pipeline/deutch-sarcastic-detection-model/ /models/sarcastic-model

# Set environment variables
ENV MODEL_NAME=sarcastic-model
ENV MODEL_BASE_PATH=/models
ENV PORT=8501

# Set TF environment variables for minimal resource usage
ENV TF_CPP_MIN_LOG_LEVEL=2
ENV TF_FORCE_GPU_ALLOW_GROWTH=true
ENV MALLOC_ARENA_MAX=2

# Create a simple startup script
RUN echo '#!/bin/bash\n\
    exec tensorflow_model_server \
    --port=8500 \
    --rest_api_port=$PORT \
    --model_name=$MODEL_NAME \
    --model_base_path=$MODEL_BASE_PATH/$MODEL_NAME \
    --tensorflow_session_parallelism=0 \
    --tensorflow_intra_op_parallelism=0 \
    --tensorflow_inter_op_parallelism=0 \
    --num_load_threads=0 \
    --num_unload_threads=0 \
    --rest_api_num_threads=1 \
    --grpc_max_threads=1 \
    --enable_batching=false \
    --enable_model_warmup=false \
    --file_system_poll_wait_seconds=0 \
    --flush_filesystem_caches=false \
    --per_process_gpu_memory_fraction=0.1' > /usr/local/bin/start_server.sh && \
    chmod +x /usr/local/bin/start_server.sh

# Use the shell script as the entry point
ENTRYPOINT ["/usr/local/bin/start_server.sh"]