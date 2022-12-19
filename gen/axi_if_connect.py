import time
import re
import os
import sys
import argparse
from mako.template import Template
from mako.lookup import TemplateLookup

class connect_list():
    def __init__(self):
        self.num_master=0
        self.num_slave=0

class axi_if_connect(object):
    def __init__(self):
        self.template_dir='F:/script/uvm_gen_auto_beng/template'
        self.out_dir='F:/script/uvm_gen_auto_beng/test/'
        self.num_master=0
        self.num_slave=0
        self.connect_list=connect_list()

    def gen_axi_connect(self):
        file_name = 'axi_if_connect.sv'
        template_lookup = TemplateLookup(directories=self.template_dir)
        template = Template("""<%include file="axi_if_connect_template.mako"/> """, lookup=template_lookup)
        cleaned_up_output = template.render(attributes=self.connect_list)  # attributes是一个字典用于获取变量
        out_file_path = self.out_dir + file_name
        try:
            file = open(out_file_path,'w+',newline='')
        except:
            print('Could not open file')
        with file:  #with的话无论file有没有写成功都会close file，可以自动释放资源
            file.write(cleaned_up_output)

    def gen_connect_list(self):
        self.connect_list.num_master = self.num_master
        self.connect_list.num_slave = self.num_slave

    def run_flow(self):
        self.gen_connect_list()
        self.gen_axi_connect()



if __name__ == '__main__':
    axi_if = axi_if_connect()
    axi_if.num_master = 3
    axi_if.num_slave = 1
    axi_if.run_flow()
