
import time
import re
import os
import sys
import argparse
from mako.template import Template
from mako.lookup import TemplateLookup

class UserError(Exception):
  def __init__(self,value):
    self.value = value
  def __str__(self):
    return str(self.value)
class BaseUvmGen(object):
    def __init__(self,name,type):
        self.institution = 'Houmo.Ai'
        self.name = name
        self.type = type
        self.out_dir = ""

    def set_outDir(self, dir):
        self.out_dir = dir

class ItemVarGenClass(BaseUvmGen):
    def __init__(self,name,width,type,isrand=False,iscompare=True):
        super(ItemVarGenClass,self).__init__(name,width)
        self.isrand=isrand
        self.iscompare = iscompare
        self.iscopy

class PortClass(BaseUvmGen):
    def __init__(self,name,width,portdir):
        super(PortClass,self).__init__(name,width)
        self.portdir=portdir           #'input' 'output' 'inout'
        if(self.portdir not in ['input' 'output' 'inout']):
            raise UserError("Port direction ("+dir+") must be input,output or inout")

class InterfaceClass(BaseUvmGen):
    def __init__(self):
        super(InterfaceClass,self).__init__(name,'interface')
        self.ports = []

    def addPort(self,name,width,portdir):
        """Add an interface port definition"""
        self.ports.append(PortClass(name,width,portdir))

class autogen_agent(object):
    def __init__(self):
        #self.module_name=''
        self.institution = 'Houmo.Ai'
        self.agent_name='op_misc'
        self.out_dir=''
        self.time = time.strftime("%Y-%m-%d", time.localtime())
        self.user='beng.jiang'
        self.agent_list={}
        self.template_dir='F:/效率/script/uvmgen/uvm_gen_auto_beng/uvm_gen/uvm_agent_gen/template'
        # self.agent_list.setdefault('agent_name',None)            #给字典添加键并设置默认值
        # self.agent_list.setdefault('user_name','bengjiang')
        # self.agent_list.setdefault('date','')

    def parser_agent_para(self):
        self.agent_list['inst'] = self.institution
        self.agent_list['agent_name'] = self.agent_name
        self.agent_list['user_name'] = self.user
        self.agent_list['date'] = self.time

    def gen_agent_file(self):
        agent_file = self.agent_name+"_agent\\"
        current_file = os.getcwd()
        if not os.path.exists("agent"):
            os.mkdir("../agents/"+self.agent_name+"_agent")

        self.out_dir = current_file+"\..\\agents\\"+agent_file
        print("print out dir:%s" %self.out_dir)


    def gen_agent(self):
        file_name = self.agent_name+'_agent.svh'
        template_lookup = TemplateLookup(directories='F:/效率/script/uvmgen/uvm_gen_auto_beng/uvm_gen/uvm_agent_gen/template')
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
        file_name = self.agent_name + '_item.svh'
        template_lookup = TemplateLookup(directories='F:/效率/script/uvmgen/uvm_gen_auto_beng/uvm_gen/uvm_agent_gen/template')
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
        file_name = self.agent_name + '_cfg.svh'
        template_lookup = TemplateLookup(directories='F:/效率/script/uvmgen/uvm_gen_auto_beng/uvm_gen/uvm_agent_gen/template')
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
        file_name = self.agent_name + '_sequencer.svh'
        template_lookup = TemplateLookup(directories='F:/效率/script/uvmgen/uvm_gen_auto_beng/uvm_gen/uvm_agent_gen/template')
        template = Template("""<%include file="sequencer_template.mako"/> """, lookup=template_lookup)
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
        file_name = self.agent_name + '_driver.svh'
        template_lookup = TemplateLookup(directories='F:/效率/script/uvmgen/uvm_gen_auto_beng/uvm_gen/uvm_agent_gen/template')
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
        file_name = self.agent_name + '_monitor.svh'
        template_lookup = TemplateLookup(directories='F:/效率/script/uvmgen/uvm_gen_auto_beng/uvm_gen/uvm_agent_gen/template')
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
        file_name = self.agent_name + '_interface.svh'
        template_lookup = TemplateLookup(directories='F:/效率/script/uvmgen/uvm_gen_auto_beng/uvm_gen/uvm_agent_gen/template')
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
        file_name = self.agent_name + 'agent_pkg.sv'
        template_lookup = TemplateLookup(directories='F:/效率/script/uvmgen/uvm_gen_auto_beng/uvm_gen/uvm_agent_gen/template')
        template = Template("""<%include file="agent_pkg_template.mako"/> """, lookup=template_lookup)
        cleaned_up_output = template.render(attributes=self.agent_list)
        out_file_path = self.out_dir + file_name
        try:
            file = open(out_file_path, 'w+', newline='')
        except:
            print('Could not open file')
        with file:  # with的话无论file有没有写成功都会close file，可以自动释放资源
            file.write(cleaned_up_output)

    def create(self,type,name,template,template_dir):
        file_name = name + '_'+type+'.svh'
        #template_lookup = TemplateLookup(directories=template_dir)
        #template = Template("""<%include file="sequencer_template.mako"/> """, lookup=template_lookup)
        cleaned_up_output = template.render(attributes=self.agent_list)
        out_file_path = self.out_dir + file_name
        print("out_file_path: %s" % out_file_path)
        try:
            file = open(out_file_path, 'w+', newline='')
        except:
            print('Could not open file')
        with file:  # with的话无论file有没有写成功都会close file，可以自动释放资源
            file.write(cleaned_up_output)

    def run_template(self):
        self.parser_agent_para()
        template_dir='F:/效率/script/uvmgen/uvm_gen_auto_beng/uvm_gen/uvm_agent_gen/template'
        template_lookup = TemplateLookup(directories=template_dir)
        template_files = []
        for root, dirs, files in os.walk(template_dir):
            print(dirs)
            for filename in files:
                if filename.endswith('.mako'):
                    print(filename)
                    type_name = text.split("_template ")
                    template = template_lookup.get_template(filename)
                    cleaned_up_output = template.render(attributes=self.agent_list)
                    if('pkg' not in filename):
                        out_file_path = self.out_dir + self.agent_list['agent_name']  +type_name +"svh"
                    else:
                        out_file_path = self.out_dir + self.agent_list['agent_name'] + type_name + "sv"
                    print("out_file_path: %s" % out_file_path)
                    try:
                        file = open(out_file_path, 'w+', newline='')
                    except:
                        print('Could not open file')
                    with file:  # with的话无论file有没有写成功都会close file，可以自动释放资源
                        file.write(cleaned_up_output)
                    #template_files.append(os.path.join(root, filename))

        # for template_name in template_lookup.template_collection.sorted():
        #     template = mylookup.get_template(template_name)
        #     print(template.filename)


if __name__ == '__main__':
    agent =autogen_agent()
    agent.run_template()


