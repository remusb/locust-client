#!/usr/bin/env sh

if [ -z "${TARGET_URL}" ]; then
  echo "ERROR: TARGET_URL not configured" >&2
  exit 1
fi

if [ -n "${LOCUSTFILE_URL}" ]; then
  curl -o "${LOCUSTFILE_PATH}" "${LOCUSTFILE_URL}"
fi

LOCUST_MODE="${LOCUST_MODE:=standalone}"
LOCUST_OPTS="-f ${LOCUSTFILE_PATH:-/locustfile.py} -H ${TARGET_URL} ${LOCUST_OPTS}"

if [ "${LOCUST_MODE}" = "master" ]; then
    LOCUST_OPTS="${LOCUST_OPTS} --master"
elif [ "${LOCUST_MODE}" = "slave" ]; then
    if [ -z "${LOCUST_MASTER_HOST}" ]; then
        echo "ERROR: MASTER_HOST is empty. Slave mode requires a master" >&2
        exit 1
    fi

    LOCUST_OPTS="${LOCUST_OPTS} --slave --master-host=${LOCUST_MASTER_HOST} --master-port=${LOCUST_MASTER_PORT:-5557}"
fi

echo "Starting Locust..."
echo "$ locust ${LOCUST_OPTS}"

locust ${LOCUST_OPTS}
