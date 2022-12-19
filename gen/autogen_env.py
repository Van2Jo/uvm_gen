
import time
import re
import os
import sys
import argparse
from mako.template import Template
from mako.lookup import TemplateLookup


class gen_env(object):
    def __init__(self):
        self.module_name=''
        self.out_dir="F:/效率/script/uvm_gen_auto_beng/test/"
        self.time = time.strftime("%Y-%m-%d", time.localtime())
        self.user=''
        self.env_list={}
        self.axi_cfg_list={}
        self.agents={}
        self.template_dir='F:/效率/script/uvm_gen_auto_beng/template'

    def gen_env(self):
        file_name = self.env_list['module_name']+'_env.sv'
        template_lookup = TemplateLookup(directories='F:/效率/script/uvm_gen_auto_beng/template')
        print(template_lookup)
        template = Template("""<%include file="env_template.mako"/> """, lookup=template_lookup)
        cleaned_up_output = template.render(attributes=self.env_list,agents=self.agents)    #attributes是一个字典用于获取变量
        out_file_path= self.out_dir + file_name
        try:
            file = open(out_file_path,'w+',newline='')
        except:
            print('Could not open file')
        with file:  #with的话无论file有没有写成功都会close file，可以自动释放资源
            file.write(cleaned_up_output)

    def parser_env_para(self):
        self.env_list.setdefault('module_name',None)            #给字典添加键并设置默认值
        self.env_list.setdefault('user_name','bengjiang')
        self.env_list.setdefault('date','')
        self.env_list.setdefault('vip', None)
        uvmcodegen_description = "uvmcodegen  <template_data_directory>  <template_directory> <output_directory> <template_data_file> "
        parser = argparse.ArgumentParser(description=uvmcodegen_description)
        parser.add_argument('-module', type=str, help='module name',default='')
        parser.add_argument('-user', type=str, help='user name', default='bengjiang')
        parser.add_argument(
            "-agents",
            nargs="+",
            metavar="agt1 agt2",
            help="""Env creates an interface agent specified here. They are
                    assumed to already exist. Note that the list is space-separated,
                    and not comma-separated. (ignored if -e switch is not passed)"""
        )
        parser.add_argument('-vip', type=str, help='amba vip , support AMBA AXI and APB', default='')
        args = parser.parse_args()
        self.env_list['module_name'] = args.module
        self.env_list['user_name'] = args.user
        self.env_list['date'] = self.time
        self.env_list['vip'] = args.vip
        self.agents = args.agents

    def run_flow(self):
        self.parser_env_para()
        self.gen_env()


if __name__ == '__main__':
    env = gen_env()
    env.run_flow()
