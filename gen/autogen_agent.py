
import time
import re
import os
import sys
import argparse
from mako.template import Template
from mako.lookup import TemplateLookup


class autogen_agent(object):
    def __init__(self):
        self.module_name=''
        self.out_dir="F:/script/uvm_gen_auto_beng/test/"
        self.time = time.strftime("%Y-%m-%d", time.localtime())
        self.user=''
        self.agents
        self.template_dir='F:/script/uvm_gen_auto_beng/template'

    def gen_agent(self):
        file_name = self.env_list['module_name']+'_agent.sv'
        template_lookup = TemplateLookup(directories='F:/script/uvm_gen_auto_beng/template')
        print(template_lookup)
        template = Template("""<%include file="env_template.mako"/> """, lookup=template_lookup)
        cleaned_up_output = template.render(attributes=self.env_list)    #attributes是一个字典用于获取变量
        out_file_path= self.out_dir + file_name
        try:
            file = open(out_file_path,'w+',newline='')
        except:
            print('Could not open file')
        with file:  #with的话无论file有没有写成功都会close file，可以自动释放资源
            file.write(cleaned_up_output)


    def run_flow(self):
        self.parser_env_para()
        self.gen_env()


