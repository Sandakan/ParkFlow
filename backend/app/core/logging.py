import sys
import logging
from loguru import logger

# Third-party loggers that emit too many DEBUG/INFO messages to be useful.
# Raise these to WARNING to keep the log output clean.
_NOISY_LOGGERS = [
    "pymongo",
    "motor",
    "urllib3",
    "httpcore",
    "httpx",
    "asyncio",
    "watchfiles",
]


def setup_logging() -> None:
    """
    Configure loguru as the single logging sink for the application.
    Removes the default handler and adds a structured, coloured stderr sink.
    Intercepts stdlib `logging` so third-party libraries (uvicorn, motor, etc.)
    route through loguru automatically.
    """
    logger.remove()  # Remove default handler

    logger.add(
        sys.stderr,
        level="DEBUG",
        format=(
            "<green>{time:YYYY-MM-DD HH:mm:ss.SSS}</green> | "
            "<level>{level: <8}</level> | "
            "<cyan>{name}</cyan>:<cyan>{function}</cyan>:<cyan>{line}</cyan> - "
            "<level>{message}</level>"
        ),
        colorize=True,
        backtrace=True,
        diagnose=True,
    )

    # Intercept stdlib logging (used by uvicorn, motor, httpx, etc.)
    class InterceptHandler(logging.Handler):
        def emit(self, record: logging.LogRecord) -> None:
            try:
                level = logger.level(record.levelname).name
            except ValueError:
                level = record.levelno

            frame, depth = logging.currentframe(), 2
            while frame and frame.f_code.co_filename == logging.__file__:
                frame = frame.f_back
                depth += 1

            logger.opt(depth=depth, exception=record.exc_info).log(
                level, record.getMessage()
            )

    logging.basicConfig(handlers=[InterceptHandler()], level=0, force=True)

    # Suppress chatty third-party loggers — raise them to WARNING
    for name in _NOISY_LOGGERS:
        logging.getLogger(name).setLevel(logging.WARNING)


__all__ = ["logger", "setup_logging"]
