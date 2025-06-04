# :PROPERTIES:
# :ID:       48837937-f5a7-4aa8-b7ca-cd2142a0bd82
# :header-args: :tangle py/csv.py :comments both
# :END:
# #+title: persist/csv/py


# 读写 CSV 的简单类型

# [[file:../20250516211116-persist_csv_py.org::+BEGIN_SRC python][No heading:1]]
class CSVReader:
    def __init__(self, filename, delimiter=','):
        self.filename = filename
        self.delimiter = delimiter
    
    def read(self):
        with open(self.filename, 'r') as f:
            return [line.strip().split(self.delimiter) for line in f]

class CSVWriter:
    def __init__(self, filename, delimiter=','):
        self.filename = filename
        self.delimiter = delimiter
    
    def write(self, data):
        with open(self.filename, 'w') as f:
            for row in data:
                line = self.delimiter.join(str(item) for item in row)
                f.write(line + '\n')
# No heading:1 ends here




# 接口方法.

# [[file:../20250516211116-persist_csv_py.org::+BEGIN_SRC python][No heading:2]]
def read_csv(filename, delimiter=','):
    return CSVReader(filename, delimiter).read()

def write_csv(filename, data, delimiter=','):
    CSVWriter(filename, delimiter).write(data)
# No heading:2 ends here
