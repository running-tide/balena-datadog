This repo was created to demonstrate some bugs that my team has encountered integrating Balena and Datadog.

## Desired Behavior
Any time services are restarted or when a new release is pushed, the Datadog agent starts up. Once it is ready to start sending logs, `app.py` should start running. `app.py` prints a counter every second.

We tried to ensure that `app.py` would not be run until Datadog was ready to send logs by checking Datadog's health (see `wait-for-datadog.sh`).

## Bugs

1. Sometimes, after pushing a new release, logs won't get sent to Datadog. Both services are running, but the Datadog agent reports "No data received" and does not send any logs. This issue is fixed with a service restart.

1. The first ~10 seconds of logs do not get sent to Datadog.

1. Some logs are sent to Datadog twice. There is no clear pattern.

## Additional Details

* `DD_API_KEY` is set as a variable in the Balena UI.
* Fleet: aarch64 (architecture), Microservices
* Device: Raspberry Pi 4 (using 64bit OS), balenaOS 2.94.4