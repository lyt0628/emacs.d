# :PROPERTIES:
# :ID:       db7a9abc-a2c0-4df7-99b9-bd545e7331c1
# :header-args: :tangle py/hash_utils.py :comments both
# :END:
# #+title: py/util/hash_utils


# [[file:../20250517113521-py_util_hash_utils.org::+BEGIN_SRC python][No heading:1]]
import math
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
