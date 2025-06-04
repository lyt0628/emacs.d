# :PROPERTIES:
# :ID:       7292c5e3-ba57-41d2-b19c-09a7ab33e286
# :header-args: :tangle py/dict_utils.py :comments both
# :END:
# #+title: py/uitl/dict_utils



# [[file:../20250516220952-py_uitl_invert_dict_list.org::+BEGIN_SRC python][No heading:1]]
def invert_dict_list(original):
    return {
        item: key
        for key, items in original.items()
        for item in items
    }
# No heading:1 ends here
