FROM tensorflow/serving:latest

COPY ./serving_model/daffa-mh-pipeline/deutch-sarcastic-detection-model /models
COPY ./config /model_config

ENV MODEL_NAME=deutch-sarcastic-detection-model
ENV MODEL_BASE_PATH="/models"
ENV MONITORING_CONFIG="/model_config/prometheus.config"
ENV PORT=8501

RUN echo '#!/bin/bash \n\n\
    env \n\
    tensorflow_model_server --port=8500 --rest_api_port=${PORT} \
    --model_name=${MODEL_NAME} --model_base_path=${MODEL_BASE_PATH}/${MODEL_NAME} \
    "$@"' > /usr/bin/tf_serving_entrypoint.sh \
    && chmod +x /usr/bin/tf_serving_entrypoint.sh  

ENTRYPOINT ["/usr/bin/tf_serving_entrypoint.sh"]
