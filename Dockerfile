# FROM tensorflow/serving
# COPY superFinalModel /superFinalModel
# CMD ["tensorflow_model_server","--host=0.0.0.0", "--port=8500","--rest_api_port=${PORT}","--model_name=recomm", "--model_base_path=/superFinalModel/model/"]


FROM tensorflow/serving

ENV MODEL_BASE_PATH /superFinalModel/model/
ENV MODEL_NAME recomm

COPY superFinalModel /superFinalModel

# Fix because base tf_serving_entrypoint.sh does not take $PORT env variable while $PORT is set by Heroku
# CMD is required to run on Heroku
COPY tf_serving_entrypoint.sh /usr/bin/tf_serving_entrypoint.sh
RUN chmod +x /usr/bin/tf_serving_entrypoint.sh
ENTRYPOINT []
CMD ["/usr/bin/tf_serving_entrypoint.sh"]