# :PROPERTIES:
# :ID:       aca71c34-7189-4aa5-912c-1ec86c4699b3
# :header-args: :tangle py/hopkins.py :comments both
# :END:
# #+title: ml/cluster/hopkins


# [[file:../20250517141754-ml_cluster_hopkins.org::+BEGIN_SRC python][No heading:1]]
def hopkins(data, sample_ratio=0.3, random_seed=None):
    """
    计算霍普金斯统计量
    参数:
        data: 二维列表，形状为[[x1,y1,...], [x2,y2,...], ...]
        sample_ratio: 采样比例（默认0.3）
        random_seed: 随机种子
    返回:
        H: 霍普金斯统计量（0-1之间）
    """
    if random_seed is not None:
        random.seed(random_seed)
    
    n = len(data)       # 样本数
    d = len(data[0])    # 特征维度
    m = int(sample_ratio * n)  # 采样点数
    
    # 1. 计算数据范围
    mins = [min(col) for col in zip(*data)]
    maxs = [max(col) for col in zip(*data)]
    
    # 2. 生成均匀随机样本
    uniform_samples = [
        [random.uniform(mins[j], maxs[j]) for j in range(d)]
        for _ in range(m)
    ]
    
    # 3. 从原始数据随机采样（不重复）
    data_samples = random.sample(data, m)
    
    # 4. 计算距离函数
    def euclidean_distance(a, b):
        return math.sqrt(sum((x-y)**2 for x,y in zip(a,b)))
    
    # 5. 计算最近邻距离
    sum_u = 0  # 均匀样本距离和
    sum_w = 0  # 实际样本距离和
    
    for sample in uniform_samples:
        min_dist = float('inf')
        for point in data:
            dist = euclidean_distance(sample, point)
            if dist < min_dist:
                min_dist = dist
        sum_u += min_dist
    
    for sample in data_samples:
        min_dist = float('inf')
        for point in data:
            if point != sample:  # 排除自身
                dist = euclidean_distance(sample, point)
                if dist < min_dist:
                    min_dist = dist
        sum_w += min_dist
    
    # 6. 计算统计量
    H = sum_u / (sum_u + sum_w)
    return H
# No heading:1 ends here
