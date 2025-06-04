# :PROPERTIES:
# :ID:       dfd0572a-7d4b-4be7-bca4-53adbcdac30d
# :header-args: :tangle py/dbscan.py :comments both
# :END:
# #+title: ml/cluster/dbscan/py


# [[file:../20250517111229-ml_cluster_dbscan_py.org::+BEGIN_SRC python][No heading:1]]
import hashs
import random
import math
import distances
import logging
from collections import deque


logger = logging.getLogger(__name__)
# No heading:1 ends here


def lookup_neighbors(data, epsilon, table, bucket_index):
    neighbor_index = []
    for idx, point in enumerate(data):
        h = bucket_index[idx]
        bucket = table[h]
        neighbors = []
        for maybe_neighbor in bucket:
            if maybe_neighbor == idx:
                continue

            if distances.euclidean(point, data[maybe_neighbor]) <= epsilon:
                neighbors.append(maybe_neighbor)
        neighbor_index.append(neighbors)
        # logger.info(f"point {idx} with neighbors {neighbors}")
        if len(neighbors) == 0:
            logger.info(f"point {idx} has no neighbor")
    return neighbor_index

# [[file:../20250517111229-ml_cluster_dbscan_py.org::+BEGIN_SRC python][No heading:2]]
def dbscan(data, epsilon, min_neighbors, width=5):
    data_size = len(data)
    dims = len(data[0])
    e2lsh = hashs.E2LSH(dims, width)
    bucket_index = []
    labels = [None] * data_size
    table = {}
    # Hash 分桶
    for idx, point in enumerate(data):
        h = e2lsh.hash(point)
        bucket = table.get(h, [])
        bucket.append(idx)
        table[h] = bucket
        bucket_index.append(h)

    neighbor_index = lookup_neighbors(data, epsilon, table, bucket_index)


    for idx in range(len(data)):
        q = deque()
        if(labels[idx] == None):
            labels[idx] = idx
            q.append(idx)
        else: # 跳过已经访问的的店
            continue
        
        if(len(neighbor_index[idx]) < min_neighbors): # 过滤噪声点
            labels[idx] = -1
            continue

        while len(q) > 0:
            current = q.pop()
            current_label = labels[current]
            neighbors = neighbor_index[current]
            
            valid_neighbors = filter(lambda neighbor: labels[neighbor] == None ,
                               neighbors)
            for n in valid_neighbors:
                labels[n] = current_label

            q.extend(valid_neighbors)

    return [None if x == -1 else x for x in labels ]
# No heading:2 ends here
