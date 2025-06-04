
import numpy as np
import pandas as pd
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import silhouette_score
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# 数据加载和预处理
data = pd.read_csv('D:\\BaiduNetdiskDownload\\数据挖掘与大数据实验二\\clusters_4d_data.csv')
X = data.values
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

kmeans = KMeans(n_clusters=3, random_state=42)
clusters = kmeans.fit_predict(X_scaled)

score = silhouette_score(X_scaled, clusters)
print(f"Silhouette Score: {score:.3f}")

# 3D可视化
fig = plt.figure(figsize=(10, 7))
ax = fig.add_subplot(111, projection='3d')
scatter = ax.scatter(X_scaled[:,0], X_scaled[:,1], X_scaled[:,2],
                    c=clusters, cmap='viridis', s=50)


plt.colorbar(scatter)
ax.set_title(f'3D Cluster Visualization (k=3, Score={score:.2f})')
plt.show()
