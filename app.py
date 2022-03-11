import logging
import time


logging.basicConfig(level=logging.INFO)


def start():
    """Prints a counter every 30 seconds."""
    counter = 0
    while True:
        logging.info("[Datadog Debug] " + str(counter))
        time.sleep(1)
        counter += 1


if __name__ == "__main__":
    start()
