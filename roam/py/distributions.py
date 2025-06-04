# :PROPERTIES:
# :ID:       42923711-fe51-4122-9c42-5f8887afe801
# :header-args: :tangle py/distributions.py :comments both
# :END:
# #+title: py/util/distributions

# 分布工具


# [[file:../20250517115402-py_util_dist_utils.org::+BEGIN_SRC python][No heading:1]]
import random
# No heading:1 ends here

# [[file:../20250517115402-py_util_dist_utils.org::+BEGIN_SRC python][No heading:2]]
def avange(a, b, size):
    return [random.uniform(a, b) for _ in range(size)]
# No heading:2 ends here

# [[file:../20250517115402-py_util_dist_utils.org::+BEGIN_SRC python][No heading:3]]
def gauss(size):
    return [random.gauss(0, 1) for _ in range(size)]
# No heading:3 ends here
