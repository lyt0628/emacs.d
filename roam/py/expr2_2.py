import dbscan
import csv_utils as csv
import time_utils
import matplotlib.pyplot as plt
import sys
import logging

logging.basicConfig(
    level=logging.DEBUG,  # 生产环境建议INFO级别
    format='%(asctime)s [%(levelname)s] %(name)s: %(message)s',
    datefmt="%Y-%m-%d %H:%M:%S",  # 修正秒格式应为%S
    handlers=[
        logging.FileHandler('app.log', encoding='utf-8'),
        logging.StreamHandler(sys.stdout)
    ]
)

logger = logging.getLogger(__name__)

data_path = 'D:\\BaiduNetdiskDownload\\数据挖掘与大数据实验二\\task2.csv'

if __name__ == "__main__":
    with time_utils.timer():
        data = csv.read_csv(data_path)
        data = [tuple(map(float, row)) for row in data]
 
        labels = dbscan.dbscan(data, 0.7, 3, 0.5)

        x = [row[0] for row in data]
        y = [row[1] for row in data]
        plt.figure(figsize=(8, 6))
        plt.scatter(x, y, 
                    c=labels,        # 点颜色
                    alpha=0.6,       # 透明度
                    edgecolors='w',  # 边缘色
                    s=30)   
        plt.title('DBSCan Graph', fontsize=14)
        plt.xlabel('X', fontsize=12)
        plt.ylabel('Y', fontsize=12)

        plt.grid(True, linestyle='--', alpha=0.5)
        
        # 显示图形labels
        plt.show()
        ls = [x for x in labels if x is not None]
        logger.info(set(sorted(ls)))
