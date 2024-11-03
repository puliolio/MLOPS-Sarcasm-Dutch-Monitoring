# Use TensorFlow Serving as the base image
FROM tensorflow/serving:latest

# Copy the model directory to the models folder inside the container
COPY ./serving_model /models

# Set environment variables
ENV MODEL_NAME=deutch-sarcastic-detection-model
ENV MODEL_BASE_PATH=/models

# Railway assigns the `PORT` dynamically, so we need to listen on that
ENV PORT=$PORT

# Expose the dynamically assigned port
EXPOSE $PORT

# Set entrypoint to launch TensorFlow Serving
ENTRYPOINT ["/usr/bin/tensorflow_model_server", "--port=8500", "--rest_api_port=${PORT}", "--model_name=${MODEL_NAME}", "--model_base_path=${MODEL_BASE_PATH}/${MODEL_NAME}"]
