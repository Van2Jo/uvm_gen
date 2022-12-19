import time
import re
import os
import sys
import argparse
import pandas as pd
from mako.template import Template
from mako.lookup import TemplateLookup
class inf_param():
    def __init__(self):
        self.name = ""
        self.width=1
        self.type=0

class gen_interface():
    def __init__(self):
        self.inf_params={}

    def read_excel(self):
        param = inf_param()
        dataframe = pd.read_excel("../Excel/interface.xlsx")
        print(dataframe)
        all_cols = dataframe.columns
        print(all_cols)
        cols = list(dataframe.columns)  #转换成列表格式
        print(cols)
        all_datas = dataframe.values  #获取所有行数据
        print(all_datas)
        for all_data in all_datas:
            print(all_data)
            for all_data_col in all_data:
                print(all_data_col)
        # for col in cols:
        #     col_datas = dataframe[col] #获取列数据
        #     if col == 'name':
        #         for col_data in col_datas:
        #             param.name
        #
        #     print("获取列数据")
        #     print(col_data)
        #     col_list = list(col_data)
        #     print(col_list)




if __name__ == "__main__":
    gen_if = gen_interface()
    gen_if.read_excel()
