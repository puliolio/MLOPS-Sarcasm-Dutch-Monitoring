FROM tensorflow/serving:latest

# Copy the model to the container
COPY ./output/serving_model/daffamh-pipeline/deutch-sarcastic-detection-model/ /models/sarcastic-model

# Set environment variables
ENV MODEL_NAME=sarcastic-model
ENV MODEL_BASE_PATH=/models
ENV PORT=8501


# Specify the CMD directly without a custom script
CMD tensorflow_model_server --port=8500 --rest_api_port=${PORT} \
    --model_name=${MODEL_NAME} --model_base_path=${MODEL_BASE_PATH}/${MODEL_NAME} \
    --tensorflow_session_parallelism=1 --tensorflow_intra_op_parallelism=1 --tensorflow_inter_op_parallelism=1 "$@"