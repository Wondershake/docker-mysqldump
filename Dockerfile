FROM alpine:3.6
LABEL maintainer="Wondershake"

ENV MYSQL_HOST "127.0.0.1"
ENV MYSQL_PORT "3306"
ENV MYSQL_USER "root"
ENV MYSQL_PASS ""
ENV MYSQL_DATABASE ""

ENV BACKUP_TO "s3"

ENV AWS_ACCESS_KEY_ID ""
ENV AWS_SECRET_ACCESS_KEY ""
ENV S3_BUCKET ""
ENV S3_PREFIX ""

ENV GCLOUD_SDK_VERSION "170.0.0"
ENV BZIP2_LEVEL "9"

RUN apk update \

  # Install Dependencies
  && apk --no-cache add \
    bash \
    python2 \
    py-pip \
    mariadb-client \

  && apk --no-cache add --virtual .build-deps \
    curl \

  # AWS CLI
  && pip --no-cache-dir install \
    awscli \

  # Google Cloud SDK
  && mkdir /opt \
  && cd /opt \
  && curl -o /opt/google-cloud-sdk.tar.gz \
    https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
  && tar zxf google-cloud-sdk.tar.gz \
  && rm google-cloud-sdk.tar.gz \
  && CLOUDSDK_PYTHON=$(which python2) \
    google-cloud-sdk/install.sh \
    --usage-reporting=false \
    --rc-path=/etc/profile.d/gcloud.sh \
    --quiet \
  && bash -lc "yes | gcloud components update"

COPY entrypoint.sh /opt/entrypoint.sh

CMD sh /opt/entrypoint.sh
