# :PROPERTIES:
# :ID:       db7a9abc-a2c0-4df7-99b9-bd545e7331c1
# :header-args: :tangle py/hashs.py :comments both
# :END:
# #+title: py/util/hashs


# [[file:../20250517113521-py_util_hash_utils.org::+BEGIN_SRC python][No heading:1]]
import math
import distributions
# No heading:1 ends here



# #+RESULTS:
# [[file:c:/Users/ASUS/AppData/Local/Temp/babel-Ns3xyL//EpNzXA-1.png]]


# [[file:../20250517113521-py_util_hash_utils.org::+BEGIN_SRC python][No heading:3]]
def hlist_linear(v, a, b, size):
    return math.floor(sum([slop*val+intercept/size for slop, val, intercept  in zip(v, a, b)]))
# No heading:3 ends here

# [[file:../20250517113521-py_util_hash_utils.org::+BEGIN_SRC python][No heading:4]]
def hlist_linear2(v, a, b, size):
    return math.floor(sum([slop*val+b/size for slop, val  in zip(v, a)]))
# No heading:4 ends here



# E2LSH Hash 类. 定义为类是为了存储参数.
# dims 表示数据维度.width 表示 hash桶大小.
# E2LSH 也是线性的hash，斜率 slop 由高斯分布产生, 截距 intercept 由平均分布产生.

# [[file:../20250517113521-py_util_hash_utils.org::+BEGIN_SRC python][No heading:5]]
class E2LSH:
    def __init__(self, dims, width):
        self.dims = dims
        self.slop = distributions.gauss(dims)
        self.intercept = distributions.avange(0, width, dims)
        self.width = width

    def hash(self,v):
        return hlist_linear(v, self.slop, self.intercept, self.dims)
# No heading:5 ends here
