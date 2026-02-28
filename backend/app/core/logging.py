import sys
from loguru import logger


def setup_logging() -> None:
    """
    Configure loguru as the single logging sink for the application.
    Removes the default handler and adds a structured, coloured stderr sink.
    Intercepts stdlib `logging` so third-party libraries (uvicorn, motor, etc.)
    route through loguru automatically.
    """
    import logging

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


__all__ = ["logger", "setup_logging"]
