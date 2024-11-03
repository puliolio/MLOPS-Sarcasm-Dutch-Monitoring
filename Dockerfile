FROM tensorflow/serving:latest

# Copy the model to the container
COPY ./output/serving_model/daffamh-pipeline/deutch-sarcastic-detection-model/ /models/sarcastic-model

# Set environment variables
ENV MODEL_NAME=sarcastic-model
ENV MODEL_BASE_PATH=/models
ENV PORT=8501

# Set memory and thread limiting environment variables
ENV TF_CPP_MIN_LOG_LEVEL=2
ENV TF_FORCE_GPU_ALLOW_GROWTH=true
ENV TF_NUM_INTEROP_THREADS=1
ENV TF_NUM_INTRAOP_THREADS=1

# Create a shell script to run the server
RUN echo '#!/bin/bash\n\
    tensorflow_model_server \
    --port=8500 \
    --rest_api_port=$PORT \
    --model_name=$MODEL_NAME \
    --model_base_path=$MODEL_BASE_PATH/$MODEL_NAME \
    --tensorflow_session_parallelism=1 \
    --tensorflow_intra_op_parallelism=1 \
    --tensorflow_inter_op_parallelism=1 \
    --num_load_threads=1 \
    --num_unload_threads=1 \
    --rest_api_num_threads=2 \
    --grpc_max_threads=2 \
    --enable_batching=false \
    --enable_model_warmup=false \
    --file_system_poll_wait_seconds=0 \
    --flush_filesystem_caches=false \
    "$@"' > /usr/local/bin/start_server.sh && \
    chmod +x /usr/local/bin/start_server.sh

# Use the shell script as the entry point
CMD ["/usr/local/bin/start_server.sh"]