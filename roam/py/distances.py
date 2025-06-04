# :PROPERTIES:
# :ID:       7f614abf-b97d-4e19-a511-f2fa3fdc7def
# :header-args: :tangle py/distances.py :comments both
# :END:
# #+title: ml/distance/py


# [[file:../20250516203519-ml_distance_py.org::+BEGIN_SRC python][No heading:1]]
import math
# No heading:1 ends here

# [[file:../20250516203519-ml_distance_py.org::+BEGIN_SRC python][No heading:2]]
def euclidean(a, b):
    """计算欧氏距离"""
    return math.sqrt(sum((x - y) ** 2 for x, y in zip(a, b)))
# No heading:2 ends here
