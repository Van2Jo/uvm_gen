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

class BenCommandLineParser:
  def __init__(self,version=None,usage=None):
    self.parser = PassThroughOptionParser(version=version,usage=usage)
    self.parser.add_option("-c","--clean",dest="clean",action="store_true",help="Clean up generated code instead of generate code")
    self.parser.add_option("-q","--quiet",dest="quiet",action="store_true",help="Suppress output while running",default=False)
    self.parser.add_option("-d","--dest_dir",dest="dest_dir",action="store",type="string",help="Override destination directory.  Default is \"$CWD/uvmf_template_output\"",default="./uvmf_template_output")
    self.parser.add_option("-t","--template_dir",dest="template_dir",action="store",type="string",help="Override which template directory to utilize.  Default is relative to location of uvmf_gen.py file")
    self.parser.add_option("-o","--overwrite",dest="overwrite",action="store_true",help="Overwrite existing output files (default is to skip)",default=False)
    self.parser.add_option("-b","--debug",dest="debug",action="store_true",help=SUPPRESS_HELP,default=False)
    #self.parser.add_option("-y","--yaml",dest="yaml",action="store_true",help="Dump YAML file instead of generate code",default=False)

class BaseUvmGen(object):
    def __init__(self,name,type="logic"):
        self.institution = 'Houmo.Ai'
        self.name = name
        self.type = type            #agent ,driver, monitor, interface, sequence_item,config ,env
        self.ConfigVar = []
        self.ParamDefs = []
        self.template_dir= '/uvm_agent_gen/template'
        self.out_dir = 'out/agent/'
        self.date = time.strftime("%Y-%m-%d", time.localtime())

    def set_outDir(self, dir):
        self.out_dir = dir

    def addConfigVar(self,name,type,isrand=False,value='',comment="",upackedDim=""):
        self.ConfigVar.append(AgentConfigClass(name,type,isrand,value,comment,unpackedDim))

    def addParamDef(self, name, type, value=None):
        """Add a parameter to the package"""
        self.ParamDefs.append(ParamDef(name, type, value))

class AgentConfigClass(BaseUvmGen):
  def __init__(self,name,type,isrand=False,value='',comment="",unpackedDim=""):
    super(InterfaceConfigClass,self).__init__(name,type,isrand,comment,unpackedDim)
    self.value = value
## class to initialize command-line parser

class ParamDef(BaseUvmGen):
  def __init__(self,name,type,value):
    super(ParamDef,self).__init__(name,type)
    self.type = type
    self.value = value

class ItemVarClass(BaseUvmGen):
    def __init__(self,name,type='bit',isrand=False,iscompare=True,comment=""):
        super(ItemVarClass,self).__init__(name,type)
        self.isrand=isrand
        self.iscompare = iscompare
        self.comment=comment

class ConfigVarClass(BaseUvmGen):
    def __init__(self,name,type='bit',isrand=False, iscompare=True, comment=""):
        super(ItemVarClass,self).__init__(name,type,isrand,iscompare,comment)
        self.isrand=isrand
        self.iscompare=iscompare
        self.comment=comment

class PortClass(BaseUvmGen):
    def __init__(self,name,width,portdir):
        super(PortClass,self).__init__(name)
        self.portdir=portdir           #'input' 'output' 'inout'
        if(self.portdir not in ["input","output","inout"]):
            raise UserError("Port direction ("+portdir+") must be input,output or inout")

class BaseAgentClass(BaseUvmGen):
    def __init__(self,name):
        super(BaseAgentClass,self).__init__(name,'agent')
        self.Ports = []
        self.ItemVars = []
        #self.agent_name=''


    def addPort(self,name,width,portdir):
        """Add an interface port definition"""
        self.Ports.append(PortClass(name,width,portdir))

    def addItemVar(self,name,type,isrand,iscompare,comment=""):
        self.ItemVars.append(ItemVarClass(name,type,isrand,iscompare,comment))

    def runTemplate(self,template_dir):
        template_lookup = TemplateLookup(directories=template_dir)
        template_files = []
        ap = self.out_dir + "/" + self.name+"/"
        if (os.path.exists(ap) == False):
            #create output directory
            os.makedirs(ap)

        for root, dirs, files in os.walk(template_dir):
            #print(dirs)
            for filename in files:
                if filename.endswith('.mako'):
                    #print(filename)
                    type_name = filename.split("_template",1)
                    template = template_lookup.get_template(filename)
                    cleaned_up_output = template.render(
                                        agent_name=self.name,
                                        inst=self.institution,
                                        user=self.user,
                                        date=self.date,
                                        itemvar=self.ItemVars,              #class
                                        ports=self.Ports,
                                        configvar=self.ConfigVar,
                                        paramdef=self.ParamDefs

                    )
                    if ('pkg' not in filename):
                        out_file_path = self.out_dir + self.name +"_"+ type_name[0] + ".svh"
                    else:
                        out_file_path = self.out_dir + self.name +"_"+ type_name[0] + ".sv"
                    print("out_file_path: %s" % out_file_path)
                    try:
                        file = open(out_file_path, 'w+', newline='')
                    except:
                        print('Could not open file')
                    with file:  # with的话无论file有没有写成功都会close file，可以自动释放资源
                        file.write(cleaned_up_output)


    def create(self):
        #1.command parser
        # parser = BenCommandLineParser(version=__version__)
        #User USER for Linux or USERNAME for Windows

        if(os.name == 'nt'):
            self.user = os.environ["USERNAME"]
        else:
            self.user = os.environ["USER"]

        self.template_dir = os.path.join(os.getcwd(), "../ben_template/agent_template")
        self.runTemplate(self.template_dir)


