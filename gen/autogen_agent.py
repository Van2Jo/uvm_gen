
import time
import re
import os
import sys
import argparse
from mako.template import Template
from mako.lookup import TemplateLookup


class autogen_agent(object):
    def __init__(self):
        #self.module_name=''
        self.agent_name='pwr_ctrl'
        self.out_dir="F:/script/uvm_gen_auto_beng/test/"
        self.time = time.strftime("%Y-%m-%d", time.localtime())
        self.user=''
        self.agent_list={}
        self.template_dir='F:/script/uvm_gen_auto_beng/template'

    def parser_agent_para(self):
        self.agent_list{"agent_name"} = self.agent_name
        self.agent_list{"user"}     = self.user
        self.agent_list{"data"}     = self.time

    def gen_agent_file(self):
        agent_file = self.agent_name+"agent"
        if not path_exists(self.agent_name+"agent"):
            os.mkdir(self.agent_name+"agent")

        self.out_dir = os.getcwd+"../"+agent_file+"/"
        print("print out dir:%s" %self.out_dir)


    def gen_agent(self):
        file_name = self.agent_name+'_agent.sv'
        template_lookup = TemplateLookup(directories='F:/script/uvm_gen_auto_beng/template')
        print(template_lookup)
        template = Template("""<%include file="agent_template.mako"/> """, lookup=template_lookup)
        cleaned_up_output = template.render(attributes=self.agent_list)    #attributes是一个字典用于获取变量
        out_file_path= self.out_dir + file_name
        try:
            file = open(out_file_path,'w+',newline='')
        except:
            print('Could not open file')
        with file:  #with的话无论file有没有写成功都会close file，可以自动释放资源
            file.write(cleaned_up_output)
    def gen_agent_item(self):
        file_name = self.agent_name + '_item.sv'
        template_lookup = TemplateLookup(directories='F:/script/uvm_gen_auto_beng/template')
        template = Template("""<%include file="agent_item_template.mako"/> """, lookup=template_lookup)
        cleaned_up_output = template.render(attributes=self.agent_list)
        out_file_path = self.out_dir + file_name
        try:
            file = open(out_file_path, 'w+', newline='')
        except:
            print('Could not open file')
        with file:  # with的话无论file有没有写成功都会close file，可以自动释放资源
            file.write(cleaned_up_output)

    def gen_agent_cfg(self):
        file_name = self.agent_name + '_cfg.sv'
        template_lookup = TemplateLookup(directories='F:/script/uvm_gen_auto_beng/template')
        template = Template("""<%include file="agent_cfg_template.mako"/> """, lookup=template_lookup)
        cleaned_up_output = template.render(attributes=self.agent_list)
        out_file_path = self.out_dir + file_name
        try:
            file = open(out_file_path, 'w+', newline='')
        except:
            print('Could not open file')
        with file:  # with的话无论file有没有写成功都会close file，可以自动释放资源
            file.write(cleaned_up_output)

    def gen_sequencer(self):
        file_name = self.agent_name + '_sequencer.sv'
        template_lookup = TemplateLookup(directories='F:/script/uvm_gen_auto_beng/template')
        template = Template("""<%include file="agent_cfg_template.mako"/> """, lookup=template_lookup)
        cleaned_up_output = template.render(attributes=self.agent_list)
        out_file_path = self.out_dir + file_name
        try:
            file = open(out_file_path, 'w+', newline='')
        except:
            print('Could not open file')
        with file:  # with的话无论file有没有写成功都会close file，可以自动释放资源
            file.write(cleaned_up_output)

    def gen_driver(self):
        file_name = self.agent_name + '_driver.sv'
        template_lookup = TemplateLookup(directories='F:/script/uvm_gen_auto_beng/template')
        template = Template("""<%include file="driver_template.mako"/> """, lookup=template_lookup)
        cleaned_up_output = template.render(attributes=self.agent_list)
        out_file_path = self.out_dir + file_name
        try:
            file = open(out_file_path, 'w+', newline='')
        except:
            print('Could not open file')
        with file:  # with的话无论file有没有写成功都会close file，可以自动释放资源
            file.write(cleaned_up_output)

    def gen_monitor(self):
        file_name = self.agent_name + '_monitor.sv'
        template_lookup = TemplateLookup(directories='F:/script/uvm_gen_auto_beng/template')
        template = Template("""<%include file="monitor_template.mako"/> """, lookup=template_lookup)
        cleaned_up_output = template.render(attributes=self.agent_list)
        out_file_path = self.out_dir + file_name
        try:
            file = open(out_file_path, 'w+', newline='')
        except:
            print('Could not open file')
        with file:  # with的话无论file有没有写成功都会close file，可以自动释放资源
            file.write(cleaned_up_output)

    def gen_interface(self):
        file_name = self.agent_name + '_interface.sv'
        template_lookup = TemplateLookup(directories='F:/script/uvm_gen_auto_beng/template')
        template = Template("""<%include file="interface_template.mako"/> """, lookup=template_lookup)
        cleaned_up_output = template.render(attributes=self.agent_list)
        out_file_path = self.out_dir + file_name
        try:
            file = open(out_file_path, 'w+', newline='')
        except:
            print('Could not open file')
        with file:  # with的话无论file有没有写成功都会close file，可以自动释放资源
            file.write(cleaned_up_output)

    def gen_agent_pkg(self):
        file_name = self.agent_name + '_pkg.sv'
        template_lookup = TemplateLookup(directories='F:/script/uvm_gen_auto_beng/template')
        template = Template("""<%include file="agent_pkg_template.mako"/> """, lookup=template_lookup)
        cleaned_up_output = template.render(attributes=self.agent_list)
        out_file_path = self.out_dir + file_name
        try:
            file = open(out_file_path, 'w+', newline='')
        except:
            print('Could not open file')
        with file:  # with的话无论file有没有写成功都会close file，可以自动释放资源
            file.write(cleaned_up_output)



    def run_flow(self):
        self.parser_agent_para()
        self.gen_agent_file()
        self.gen_sequencer()
        self.gen_interface()
        self.gen_agent_cfg()
        self.gen_driver()
        self.gen_monitor()

if __main__ == '__name__':
    agent =autogen_agent()
    agent.run_flow()


