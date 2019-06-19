FROM 790510214084.dkr.ecr.eu-central-1.amazonaws.com/locust/locust

RUN apk add curl

ADD entrypoint.sh /entrypoint.sh

ENV TARGET_URL ""
ENV LOCUST_MODE "standalone"
ENV LOCUSTFILE_PATH "/locustfile.py"
ENV LOCUST_OPTS ""
ENV LOCUST_MASTER_HOST ""
ENV LOCUST_MASTER_PORT 5557
ENV LOCUSTFILE_URL ""

ENTRYPOINT ["/entrypoint.sh"]
