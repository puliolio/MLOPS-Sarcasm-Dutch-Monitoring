FROM tensorflow/serving:latest

# Copy the model to the container
COPY ./output/serving_model/daffamh-pipeline/deutch-sarcastic-detection-model/ /models/sarcastic-model

# Set environment variables
ENV MODEL_NAME=sarcastic-model
ENV MODEL_BASE_PATH=/models
ENV PORT=8501

# Set TensorFlow environment variables to limit resource usage
ENV TF_CPP_MIN_LOG_LEVEL=2
ENV TF_FORCE_GPU_ALLOW_GROWTH=true
ENV TF_NUM_INTEROP_THREADS=1
ENV TF_NUM_INTRAOP_THREADS=1

# Specify the CMD with reduced parallelism and additional optimization flags
CMD tensorflow_model_server \
    --port=8500 \
    --rest_api_port=${PORT} \
    --model_name=${MODEL_NAME} \
    --model_base_path=${MODEL_BASE_PATH}/${MODEL_NAME} \
    --tensorflow_session_parallelism=1 \
    --tensorflow_intra_op_parallelism=1 \
    --tensorflow_inter_op_parallelism=1 \
    --num_load_threads=1 \
    --num_unload_threads=1 \
    --rest_api_num_threads=2 \
    --grpc_max_threads=2 \
    --per_process_gpu_memory_fraction=0.25 \
    --enable_batching=false \
    "$@"