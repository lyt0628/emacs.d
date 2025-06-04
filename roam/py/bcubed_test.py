import bcubed as b


def test_basic_case():
    # 完全错误聚类：每个元素单独成簇
    true = ["A", "A", "B", "B"]
    pred = [0, 1, 2, 3]
    res = b.bcubed_f1(true, pred)
    
    # 修正后的预期值：
    # 每个元素的精度=1（因为簇中只有自己）
    # 每个元素的召回=0.5（因为同类有2个元素）
    assert round(res, 2) == 0.67  # 2*1*0.5/(1+0.5)
    print ("ok")

test_basic_case()
