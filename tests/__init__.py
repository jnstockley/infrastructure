import logging
import os

logger = logging.getLogger(__name__)

console_handler = logging.StreamHandler()

formatter = logging.Formatter(
        "%(asctime)s %(levelname)s %(filename)s.%(funcName)s:%(lineno)d - %(message)s")

console_handler.setFormatter(formatter)


levels = {'DEBUG': logging.DEBUG, 'INFO': logging.INFO, 'WARNING': logging.WARNING,
          'ERROR': logging.ERROR, 'CRITICAL': logging.CRITICAL}

level = 'INFO'

logger.setLevel(levels[level])
console_handler.setLevel(levels[level])
logger.addHandler(console_handler)

try:
    os.environ['LOGGING_LEVEL']
except KeyError as e:
    logger.warning("Unable to find log level, defaulting to `INFO`")

console_handler.setLevel(levels[level])
logger.setLevel(levels[level])

