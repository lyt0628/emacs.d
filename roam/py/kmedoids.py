# :PROPERTIES:
# :ID:       24443fa7-6d5a-42c6-b65c-10ceaf91c33c
# :header-args: :tangle py/kmedoids.py :comments both
# :END:
# #+title: ml/cluster/kmedoids/py

# 导入依赖，distances 里面定义了欧式距离的计算.


# [[file:../20250516203319-ml_cluster_kmedoids_py.org::+BEGIN_SRC python][No heading:1]]
import random
import math
import logging
import distances as d

logger = logging.getLogger(__name__)
# No heading:1 ends here



# k-medoids 的计算流程:
# 1. 首先随机(或者不随机)分配 k 个中心点.
# 2. 将非中心点, 关联到最近的中心点
# 3. 对于每个中心点, 计算初始代价(簇内的距离和).
# 4. 对于每个簇, 寻找簇内距离和最小的点作为新的中心点.
# 5. 如果代价更小的了, 回到步骤2 重新计算代价(一次迭代)
# 6. 否则，说明计算收敛了, 我们返回聚类结果



# [[file:../20250516203319-ml_cluster_kmedoids_py.org::+BEGIN_SRC python][No heading:3]]
def initialize_medoids(data, k):
    """随机初始化中心点"""
    return random.sample(data, k)
# No heading:3 ends here



# data 是 记录的列表.
# medoids 是中心记录的列表.
# 返回 一个字典 [medoid=>[record]].
# 对于每个记录，我们遍历中心点，将自己加入最近中心点的簇中.

# [[file:../20250516203319-ml_cluster_kmedoids_py.org::+BEGIN_SRC python][No heading:4]]
def assign_clusters(data, medoids):
    """分配数据点到最近的中心点"""
    clusters = [[] for _ in range(len(medoids))]
    for point in data:
        closest = min(range(len(list(medoids))), 
                     key=lambda i: d.euclidean(point, medoids[i]))
        clusters[closest].append(point)
    return dict(zip(medoids, clusters))
# No heading:4 ends here



# clusters: [medoid=>[record]]
# 对于每个簇，遍历所有簇内点，计算距离和.

# [[file:../20250516203319-ml_cluster_kmedoids_py.org::+BEGIN_SRC python][No heading:5]]
def calculate_total_cost(clusters):
    """计算总成本（所有点到其中心点的距离和）"""
    total = 0
    items = clusters.items()
    for medoid, points in items:
        for point in points:
            cost = d.euclidean(point, medoid)
            total += cost
            logger.debug(f"cost of medoid :{medoid} to point: {point} is: {cost}")


    return total
# No heading:5 ends here




# clusters: [medoid=>[record]]
# 对于每个簇，遍历每个节点，找到代价最小的节点作为中心.
# 返回一个中心记录的列表.

# [[file:../20250516203319-ml_cluster_kmedoids_py.org::+BEGIN_SRC python][No heading:6]]
def update_medoids(clusters):
    """更新中心点为簇内使总距离最小的点"""
    new_medoids = []
    for _, points in clusters.items():
        min_cost = float('inf')
        best_medoid = None
        for candidate in points:
            cost = sum(d.euclidean(p, candidate) for p in points)
            if cost < min_cost:
                min_cost = cost
                best_medoid = candidate
                logger.info(f"best medoid updated : {best_medoid} with cost {min_cost}")

            logger.debug(f"point: {candidate} with cost: {cost}")

        logger.info(f"final best medoid: {best_medoid} with cost: {min_cost}" )
        new_medoids.append(best_medoid)
    return new_medoids
# No heading:6 ends here



# 算法主流程, 见流程图.

# [[file:../20250516203319-ml_cluster_kmedoids_py.org::+BEGIN_SRC python :results output][No heading:7]]
def k_medoids(data, k, max_iter=100):
    """k中心点算法主函数"""
    medoids = initialize_medoids(data, k)
    logging.info(f"initial medoids: {medoids}")

    prev_cost = float('inf')

    for n in range(max_iter):
        logging.info(f"iter : {n}/{max_iter}")
        clusters = assign_clusters(data, medoids)
        current_cost = calculate_total_cost(clusters)
        logging.info(f"current cost: {current_cost}")

        if current_cost >= prev_cost:
            break

        prev_cost = current_cost
        medoids = update_medoids(clusters)
        logging.info(f"new medoids: {medoids}")


    return medoids, clusters
# No heading:7 ends here
