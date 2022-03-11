#!/bin/bash
# wait-for-datadog.sh
# Based on https://docs.docker.com/compose/startup-order

set -e
  
host="$1"
port="$2"
shift
shift

# If the API key isn't set, don't bother waiting for Datadog.
if [[ ! -z $DD_API_KEY ]]; then
    echo "[Datadog debug] Waiting for Datadog..."

    # Wait for Datadog health to be reported.
    until nc -z $host $port; do
        echo "[Datadog debug] Waiting for $host:$port..."
        sleep 1
    done

    # Wait for all Datadog components to be healthy.
    until [[ $(curl -s $host:$port | jq '.Unhealthy') ]]; do
        echo "[Datadog debug] Waiting for Datadog health..."
        sleep 1
    done

    echo "[Datadog debug] Datadog is ready..."
else
    echo "[Datadog debug] Datadog API key is unavailable..."
fi

echo "[Datadog debug] Starting app..."
exec sh -c "$@"
