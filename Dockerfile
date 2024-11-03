FROM tensorflow/serving:latest

# Copy the model and config to the container
COPY ./output/serving_model/daffamh-pipeline/deutch-sarcastic-detection-model/ /models/sarcastic-model
COPY ./config /model_config

# Set environment variables
ENV MODEL_NAME=sarcastic-model
ENV MONITORING_CONFIG=/model_config/prometheus.config 
ENV MODEL_BASE_PATH=/models
ENV PORT=8501

RUN echo '#!/bin/bash \n\n\
    env \n\
    tensorflow_model_server --port=8500 --rest_api_port=${PORT} \
    --model_name=${MODEL_NAME} --model_base_path=${MODEL_BASE_PATH}/${MODEL_NAME} \
    --monitoring_config_file=${MONITORING_CONFIG} \
    "$@"' > /usr/bin/tf_serving_entrypoint.sh \
    && chmod +x /usr/bin/tf_serving_entrypoint.sh

# Optional: Add a command to verify the config file was copied correctly
RUN ls -la /model_config
