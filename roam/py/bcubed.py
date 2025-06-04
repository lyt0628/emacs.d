# :PROPERTIES:
# :ID:       489a8470-09ce-4e86-94ef-0702c6673a72
# :header-args: :tangle py/bcubed.py :comments both :mkdirp t
# :END:
# #+title: ml/cluster/bcubed/py


# [[file:../20250516201613-ml_cluster_bcubed_py.org::+BEGIN_SRC python][No heading:1]]
def bcubed_precision(true_labels, pred_labels):
    """计算BCubed精度"""
    label_to_items = {}
    for idx, label in enumerate(pred_labels):
        label_to_items.setdefault(label, []).append(idx)
    
    precisions = []
    for i, (t, p) in enumerate(zip(true_labels, pred_labels)):
        true_set = {j for j, lbl in enumerate(true_labels) if lbl == t}
        pred_set = set(label_to_items[p])
        correct = len(true_set & pred_set)
        precisions.append(correct / len(pred_set))
    
    return sum(precisions) / len(precisions)
# No heading:1 ends here

# [[file:../20250516201613-ml_cluster_bcubed_py.org::+BEGIN_SRC python][No heading:2]]
def bcubed_recall(true_labels, pred_labels):
    """计算BCubed召回率"""
    label_to_items = {}
    for idx, label in enumerate(true_labels):
        label_to_items.setdefault(label, []).append(idx)
    
    recalls = []
    for i, (t, p) in enumerate(zip(true_labels, pred_labels)):
        true_set = set(label_to_items[t])
        pred_set = {j for j, lbl in enumerate(pred_labels) if lbl == p}
        correct = len(true_set & pred_set)
        recalls.append(correct / len(true_set))
    
    return sum(recalls) / len(recalls)
# No heading:2 ends here

# [[file:../20250516201613-ml_cluster_bcubed_py.org::+BEGIN_SRC python][No heading:3]]
def bcubed_f1(true_labels, pred_labels):
    """计算BCubed F1分数"""
    precision = bcubed_precision(true_labels, pred_labels)
    recall = bcubed_recall(true_labels, pred_labels)
    return 2 * precision * recall / (precision + recall) if (precision + recall) > 0 else 0
# No heading:3 ends here
