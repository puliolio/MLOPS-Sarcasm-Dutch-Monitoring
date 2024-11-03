# Use the TensorFlow Serving base image
FROM tensorflow/serving:latest

# Copy the model to the model directory within the container
COPY ./serving_model/daffa-mh-pipeline/deutch-sarcastic-detection-model /models/deutch-sarcastic-detection-model

# Set environment variables for TensorFlow Serving
ENV MODEL_NAME=deutch-sarcastic-detection-model
ENV MODEL_BASE_PATH=/models
ENV PORT=8501

# Expose the REST API port (8501) and gRPC port (8500)
EXPOSE 8501
EXPOSE 8500

# Set the entry point to start TensorFlow Serving
ENTRYPOINT ["/usr/bin/tensorflow_model_server", "--port=8500", "--rest_api_port=8501", "--model_name=${MODEL_NAME}", "--model_base_path=${MODEL_BASE_PATH}/${MODEL_NAME}"]
