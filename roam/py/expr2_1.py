import csv_utils as csv
import kmedoids as k
import bcubed as b
import dict_utils as u
import logging
import sys
import time_utils

logging.basicConfig(
    level=logging.DEBUG,  # 生产环境建议INFO级别
    format='%(asctime)s [%(levelname)s] %(name)s: %(message)s',
    datefmt="%Y-%m-%d %H:%M:%S",  # 修正秒格式应为%S
    handlers=[
        logging.FileHandler('app.log', encoding='utf-8'),
        logging.StreamHandler(sys.stdout)
    ]
)

data_path = 'D:\\BaiduNetdiskDownload\\数据挖掘与大数据实验二\\shuffled_4d_cluster_data_processed_3.csv'
labeled_data_path = 'D:\\BaiduNetdiskDownload\\数据挖掘与大数据实验二\\shuffled_4d_cluster_data_3.csv'



if __name__ == "__main__":
    with time_utils.timer():
        data = csv.read_csv(data_path)
        data = [tuple(map(float, row)) for row in data]
        medoids, clusters = k.k_medoids(data, 3)

        pred_data = u.invert_dict_list(clusters)
        sorted_pred = {k:pred_data[k] for k in sorted(pred_data)}
        labeled_data = csv.read_csv(labeled_data_path)
        labeled_data = {
            tuple(item[:4]): item[-1]
            for item in labeled_data
        }
        sorted_label = {k:labeled_data[k] for k in sorted(labeled_data)}
    
        score = b.bcubed_f1(sorted_label.values(), sorted_pred.values())
        print (score)
