
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
        self.out_dir=''
        self.time = time.strftime("%Y-%m-%d", time.localtime())
        self.user='beng.jiang'
        self.agent_list={}
        self.template_dir='F:/效率/script/uvmgen/uvm_gen_auto_beng/uvm_agent_gen/template'
        # self.agent_list.setdefault('agent_name',None)            #给字典添加键并设置默认值
        # self.agent_list.setdefault('user_name','bengjiang')
        # self.agent_list.setdefault('date','')

    def parser_agent_para(self):
        self.agent_list['agent_name'] = self.agent_name
        self.agent_list['user_name'] = self.user
        self.agent_list['date'] = self.time

    def gen_agent_file(self):
        agent_file = self.agent_name+"_agent\\"
        current_file = os.getcwd()
        #if not os.path.exists("agent"):
            #os.mkdir("../agents/"+self.agent_name+"_agent")

        self.out_dir = current_file+"\..\\agents\\"+agent_file
        print("print out dir:%s" %self.out_dir)


    def gen_agent(self):
        file_name = self.agent_name+'_agent.sv'
        template_lookup = TemplateLookup(directories='F:/效率/script/uvmgen/uvm_gen_auto_beng/uvm_agent_gen/template')
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
        template_lookup = TemplateLookup(directories='F:/效率/script/uvmgen/uvm_gen_auto_beng/uvm_agent_gen/template')
        template = Template("""<%include file="agent_item_template.mako"/> """, lookup=template_lookup)
        cleaned_up_output = template.render(attributes=self.agent_list)
        out_file_path = self.out_dir + file_name
        print("out_file_path: %s" %out_file_path)
        try:
            file = open(out_file_path, 'w+', newline='')
        except:
            print('Could not open file')
        with file:  # with的话无论file有没有写成功都会close file，可以自动释放资源
            file.write(cleaned_up_output)

    def gen_agent_cfg(self):
        file_name = self.agent_name + '_cfg.sv'
        template_lookup = TemplateLookup(directories='F:/效率/script/uvmgen/uvm_gen_auto_beng/uvm_agent_gen/template')
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
        template_lookup = TemplateLookup(directories='F:/效率/script/uvmgen/uvm_gen_auto_beng/uvm_agent_gen/template')
        template = Template("""<%include file="agent_cfg_template.mako"/> """, lookup=template_lookup)
        cleaned_up_output = template.render(attributes=self.agent_list)
        out_file_path = self.out_dir + file_name
        print("out_file_path: %s" % out_file_path)
        try:
            file = open(out_file_path, 'w+', newline='')
        except:
            print('Could not open file')
        with file:  # with的话无论file有没有写成功都会close file，可以自动释放资源
            file.write(cleaned_up_output)

    def gen_driver(self):
        file_name = self.agent_name + '_driver.sv'
        template_lookup = TemplateLookup(directories='F:/效率/script/uvmgen/uvm_gen_auto_beng/uvm_agent_gen/template')
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
        template_lookup = TemplateLookup(directories='F:/效率/script/uvmgen/uvm_gen_auto_beng/uvm_agent_gen/template')
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
        template_lookup = TemplateLookup(directories='F:/效率/script/uvmgen/uvm_gen_auto_beng/uvm_agent_gen/template')
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
        template_lookup = TemplateLookup(directories='F:/效率/script/uvmgen/uvm_gen_auto_beng/uvm_agent_gen/template')
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
        self.gen_agent_pkg()
        self.gen_agent_item()
        self.gen_agent()

if __name__ == '__main__':
    agent =autogen_agent()
    agent.run_flow()


