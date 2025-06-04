# :PROPERTIES:
# :ID:       dc69bca6-a76e-4a9e-be62-b50cf1774888
# :header-args: :tangle py/time_utils.py :comments both
# :END:
# #+title: py/util/time_utils


# [[file:../20250517104533-py_util_timer_utils.org::+BEGIN_SRC python][No heading:1]]
import time
from contextlib import contextmanager
import logging

logger = logging.getLogger(__name__)
# No heading:1 ends here

# [[file:../20250517104533-py_util_timer_utils.org::+BEGIN_SRC python][No heading:2]]
@contextmanager
def timer():
    start = time.perf_counter()
    yield
    end = time.perf_counter()
    logger.info(f"Used time: {end - start:.4f}s")
# No heading:2 ends here
