"""
Logging.
"""

import logging
import logging.config

from .settings import LOGGING

logging.config.dictConfig(LOGGING)


def get_logger(name: str | None = None) -> logging.Logger:
    logger = logging.getLogger(name)
    return logger
