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
        self.ConfigVar = []
        self.ParamDefs = []
        self.out_dir = ""

    def set_outDir(self, dir):
        self.out_dir = dir

    def addConfigVar(self):
        self.ConfigVar.append()

    def addParamDef(self, name, type, value=None):
        """Add a parameter to the package"""
        self.ParamDefs.append(ParamDef(name, type, value))


class ParamDef(BaseUvmGen):
  def __init__(self,name,type,value):
    super(ParamDef,self).__init__(name)
    self.type = type
    self.value = value

class ItemVarClass(BaseUvmGen):
    def __init__(self,name,width,type='bit',isrand=False,iscompare=True):
        super(ItemVarClass,self).__init__(name,width)
        self.isrand=isrand
        self.iscompare = iscompare

class ConfigVarClass(BaseUvmGen):
    def __init__(self,name,width,type='bit',isrand=False):
        super(ItemVarClass,self).__init__(name,width)
        self.isrand=isrand


class PortClass(BaseUvmGen):
    def __init__(self,name,width,portdir):
        super(PortClass,self).__init__(name,width)
        self.portdir=portdir           #'input' 'output' 'inout'
        if(self.portdir not in ['input' 'output' 'inout']):
            raise UserError("Port direction ("+dir+") must be input,output or inout")

class AgentClass(BaseUvmGen):
    def __init__(self):
        super(AgentClass,self).__init__(name,'interface')
        self.Ports = []
        self.ItemVars = []

    def initTemplateVars(self,template):
        templateVars['ItemVars'] = self.ItemVars
        templateVars['Ports'] = self.Ports
        templateVars['ConfigVar'] = self.ConfigVar
        templateVars['ParamDefs'] = self.ParamDefs

    def addPort(self,name,width,portdir):
        """Add an interface port definition"""
        self.Ports.append(PortClass(name,width,portdir))

    def addItemVar(self,name,type,width,isrand,iscompare):
        self.ItemVars.append(ItemVarClass(name,type,width,isrand,iscompare))

    def runTemplate(self, templatename, Template_dir,templateVars):

        mylookup = TemplateLookup(directories=[Template_dir])

        def serve_template(templatename, **kwargs):
            mytemplate = mylookup.get_template(templatename)
            print(mytemplate.render(**kwargs))
        for key in templateVars:
            if type(templateVars[key]) is str:
                if (key != 'root_dir'):
                    fname = re.sub('\{\{' + key + '\}\}', templateVars[key], fname)
                    serve_template(templatename,key)


    def create_agent(self):

