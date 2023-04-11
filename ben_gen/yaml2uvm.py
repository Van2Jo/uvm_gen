import sys
import os
import time
import re
import inspect
import copy
import pprint
from optparse import OptionParser, SUPPRESS_HELP
from fnmatch import fnmatch
import shutil
import argparse
from uvm_gen import BaseAgentClass

#from uvmf_yaml import  *
try:
  import yaml
except ImportError:
    print("ERROR : yaml package not found.  See templates.README for more information")
    sys.exit(1)

class UserError(Exception):
  def __init__(self,value):
    self.value = value
  def __str__(self):
    return str(self.value)

class DataClass:
  def __init__(self,parser,debug=False):
    self.data = {'agent':{},'environments':{},'benches':{}}
    self.parser = parser
    self.debug = debug
    self.validators = {}
    self.used_ac_items = []

  def parseFile(self,fname):
    print("beng dbg print fname!!!!"+fname)
    try:
      fs = open(fname)
    except IOError:
      raise UserError("Unable to open config file "+fname)
    d = yaml.safe_load(fs)
    fs.close()
    try:
      if 'uvmf' not in d.keys():
        raise UserError("Contents of "+fname+" not valid UVMF info")
    except:
      raise UserError("Contents of "+fname+" not valid UVMF info")
    for k in d['uvmf'].keys():
      if k not in self.data.keys():
        raise UserError("Top-level element \""+k+"\" in "+fname+" is not valid. Allowed entries:\n  "+str(self.data.keys()))
    for elem in self.data.keys():
      try: self.data[elem].update(d['uvmf'][elem])
      except KeyError:
        pass

  def dataExtract(self,keys,dictionary):
    ## Pull the specified keys out of the given structure. If the key
    ## does not exist return None for the given value
    ret = []
    for key in keys:
      try:
        ret = ret + [dictionary[key]]
      except KeyError:
        ret = ret + [None]
        pass
    return ret


  def buildElements(self, genarray, verify=True, build_existing=False, archive_yaml=True):
        count = 0
        self.agentDict = {}
        try:
            arrlen = len(genarray)
        except TypeError:
            arrlen = 0
            pass
        for agent_name in self.data['agent']:
            if ((arrlen > 0) and (agent_name in genarray)) or (arrlen == 0):
                self.agentDict[agent_name] = self.generateAgent(agent_name, build_existing, archive_yaml)
                count = count + 1
        #self.environmentDict = {}
        # for environment_name in self.data['environments']:
        #     if ((arrlen > 0) and (environment_name in genarray)) or (arrlen == 0):
        #         self.environmentDict[environment_name] = self.generateEnvironment(environment_name, build_existing,
        #                                                                           archive_yaml)
        #         count = count + 1
        # self.benchDict = {}
        # for bench_name in self.data['benches']:
        #     if ((arrlen > 0) and (bench_name in genarray)) or (arrlen == 0):
        #         self.benchDict[bench_name] = self.generateBench(bench_name, build_existing, archive_yaml)
        #         count = count + 1
        ## Check to see if any utility components were defined but never instantiated, flag that as a warning

        ## Verify that something was produced (possible that YAML input was empty or genarray had no matches)
        if count == 0 and verify:
            raise UserError("No output was produced!")

  def generateAgent(self,name,build_existing=False,archive_yaml=True):
    intf = BaseAgentClass(name)
    struct = self.data['agent'][name]
    print("beng debug print struct")
    print(struct)
    try:
      for imp in struct['imports']:
        intf.addImport(imp['name'])
    except KeyError: pass
    try:
      for item in struct['parameters']:
        n,t,v = self.dataExtract(['name','type','value'],item)
        intf.addParamDef(n,t,v)
    except KeyError: pass
    try:
      for item in struct['hdl_pkg_parameters']:
        n,t,v = self.dataExtract(['name','type','value'],item)
        intf.addHdlPkgParamDef(n,t,v)
    except KeyError: pass

    try:
      for item in struct['hdl_typedefs']:
        n,t = self.dataExtract(['name','type'],item)
        intf.addHdlTypedef(n,t)
    except KeyError: pass

    try:
      for port in struct['ports']:
        n,w,d = self.dataExtract(['name','width','dir'],port)
        if not re.search(r"^(input|output|inout)$",d):
          raise UserError("Direction \""+d+"\" invalid for port \""+n+"\" in interface \""+name+"\"")
        try:
          r = (port['reset_value'])
        except KeyError:
          r = "'bz"
        intf.addPort(n,w,d)
    except KeyError: pass
    try:
      for trans in struct['transaction_vars']:
        n,t,c = self.dataExtract(['name','type','comment'],trans)
        if not c:
          c = ""
        try:
          trand = (trans['isrand']=="True")
        except KeyError:
          trand = False
          pass
        try:
          tcomp = (trans['iscompare']=="True")
        except KeyError:
          tcomp = True
          pass
        try:
          ud = trans['unpacked_dimension']
        except KeyError:
          ud = ""
          pass
        intf.addItemVar(n,t,isrand=trand,iscompare=tcomp,comment=c)
    except KeyError: pass
    try:
      for cfg in struct['config_vars']:
        n,t,c = self.dataExtract(['name','type','comment'],cfg)
        if not c:
          c = ""
        try:
          crand = (cfg['isrand']=="True")
        except KeyError:
          crand = False
          pass
        cval = ''
        try:
          cval = cfg['value']
        except KeyError: pass
        try:
          cvud = cfg['unpacked_dimension']
        except KeyError:
          cvud = ""
          pass
        intf.addConfigVar(n,t,crand,cval,c,cvud)
    except KeyError: pass
    try:
      for item in struct['transaction_constraints']:
        n,v,c = self.dataExtract(['name','value','comment'],item)
        if not c:
          c = ""
        intf.addTransVarConstraint(n,v,c)
    except KeyError: pass
    # try:
    #   for item in struct['config_constraints']:
    #     n,v,c = self.dataExtract(['name','value','comment'],item)
    #     if not c:
    #       c = ""
    #     intf.addConfigVarConstraint(n,v,c)
    # except KeyError: pass
    # try:
    #   response_info = struct['response_info']
    #   resp_op = response_info['operation']
    #   intf.specifyResponseOperation(resp_op)
    #   resp_data = response_info['data']
    #   intf.specifyResponseData(resp_data)
    #   print("Warning: response_info YAML structure deprecated.  Slave agent response data now determined by arguments to respond_and_wait_for_next_transfer task within generated driver_bfm.")
    # except KeyError: pass
    # try:
    #   dpi_def = struct['dpi_define']
    #   ca = ""
    #   la = ""
    #   try:
    #     ca = dpi_def['comp_args']
    #   except KeyError: pass
    #   try:
    #     la = dpi_def['link_args']
    #   except KeyError: pass
    #   intf.setDPISOName(value=dpi_def['name'],compArgs=ca,linkArgs=la)
    #   for f in dpi_def['files']:
    #     intf.addDPIFile(f)
    #   try:
    #     for imp in dpi_def['imports']:
    #       sv_args = []
    #       try:
    #         sv_args = imp['sv_args']
    #       except KeyError: pass
    #       intf.addDPIImport(imp['c_return_type'],imp['sv_return_type'],imp['name'],imp['c_args'],sv_args)
    #   except KeyError: pass
    #   try:
    #     for exp in dpi_def['exports']:
    #       intf.addDPIExport(exp)
    #   except KeyError: pass
    # except KeyError: pass
    intf.inFactReady = ('infact_ready' in struct.keys() and struct['infact_ready'])
    try:
      intf.mtlbReady = (struct['mtlb_ready']=="True")
    except KeyError:
      pass
    try:
      intf.veloceReady = (struct['veloce_ready'] == "True")
    except KeyError:
      intf.veloceReady = True
      pass
    try:
      intf.enableFunctionalCoverage = (struct['enable_functional_coverage'] == "True")
    except KeyError: pass
#     if intf.veloceReady == True:
#       try:
#         for trans in struct['transaction_vars']:
#           try:
#             if trans['unpacked_dimension'] != "":
#               raise UserError("Interface \""+name+"\" flagged to be Veloce ready but transaction variable \""+trans['name']+"\" has specified an unpacked dimension")
#           except KeyError: pass
#       except KeyError:
#         ## If this happens it means there are no transaction variables, which is also illegal
#         raise UserError("Interface \"{0}\" flagged to be Veloce ready but no transaction variables have been defined. Must define at least one".format(name))
#         pass
#       try:
#         for cfg in struct['config_vars']:
#           try:
#             if cfg['unpacked_dimension'] != "":
#               raise UserError("Interface \""+name+"\" flagged to be Veloce ready but configuration variable \""+cfg['name']+"\" has specified an unpacked dimension")
#           except KeyError: pass
#       except KeyError: pass
#         ## If this happens it means there are no transaction variables, which is also illegal
# #        raise UserError("Interface \"{0}\" flagged to be Veloce ready but no transaction variables have been defined. Must define at least one".format(name))
# #        pass
#       ## Also possible that there was a transaction variables array defined but its empty. Also illegal
#       if len(struct['transaction_vars'])==0:
#         raise UserError("Interface \"{0}\" flagged to be Veloce ready but no transaction variables have been defined. Must define at least one".format(name))
    existing_component = False
    try:
      if not build_existing:
        existing_component = (struct['existing_library_component']=="True")
    except KeyError:
      pass
    if existing_component == True:
      print("  Skipping generation of predefined component "+str(name))
    else:
      intf.create()
    return intf


def run():
    #解析传入参数
    uvmf_parser = OptionParser(version="2023.4",usage="yaml2uvm.py [options] [yaml_file1 [yaml_fileN]]")
    uvmf_parser.add_option("-f", "--file", dest="configfile", action="append",
                                  help="Specify a file list of YAML configs. Relative paths relative to the invocation directory")
    uvmf_parser.add_option("-F", "--relfile", dest="rel_configfile", action="append",
                                  help="Specify a file list of YAML configs. Relative paths relative to the file list itself")
    uvmf_parser.add_option("-g", "--generate", dest="gen_name", action="append",
                                  help="Specify which elements to generate (default is everything)")
    uvmf_parser.add_option("-m", "--merge_source", dest="merge_source", action="store",
                                  help="Enable auto-merge flow, pulling from the specified source directory")
    uvmf_parser.add_option("-s", "--merge_skip_missing_blocks", dest="merge_skip_missing", action="store_true",
                                  help="Continue merge if unable to locate a custom block that was defined in old source, producing a report at the end. Default behavior is to raise an error",
                                  default=False)
    uvmf_parser.add_option("--merge_export_yaml", dest="merge_export_yaml", action="store", help=SUPPRESS_HELP,
                                  default=None)
    uvmf_parser.add_option("--merge_import_yaml", dest="merge_import_yaml", action="store", help=SUPPRESS_HELP,
                                  default=None)
    uvmf_parser.add_option("--merge_import_yaml_output", dest="merge_import_yaml_output", action="store",
                                  help=SUPPRESS_HELP, default="uvmf_template_merged")
    uvmf_parser.add_option("--merge_no_backup", dest="merge_no_backup", action="store_true",
                                  help="Do not back up original merge source", default=False)
    uvmf_parser.add_option("--merge_debug", dest="merge_debug", action="store_true",
                                  help="Provide intermediate unmerged output directory for debug purposes. Debug directory can be specified by --dest_dir switch.",
                                  default=False)
    uvmf_parser.add_option("--merge_verbose", dest="merge_verbose", action="store_true",
                                  help="Output more verbose messages during the merge operation for debug purposes.",
                                  default=False)
    uvmf_parser.add_option("--build_existing_components", dest="build_existing_components", action="store_true",
                                  help="Ignore \"existing_library_component\" flags and attempt to build anyway.",
                                  default=False)
    uvmf_parser.add_option("--no_archive_yaml", dest="no_archive_yaml", action="store_true", default=False,
                                  help="Disable YAML archive creation")

    (options, args) = uvmf_parser.parse_args() #option是namespace， args是参数列表
    configfiles = []
    print(options)
    try:
        configfiles = configfiles + args
    except TypeError:
        pass

    dataObj = DataClass(uvmf_parser)
    for cfg in configfiles:
        #print("beng dbg cfg: "+cfg)
        dataObj.parseFile(cfg)
    # dataObj.validate()
    dataObj.buildElements(options.gen_name, verify=options.merge_export_yaml == None,
                           build_existing=options.build_existing_components, archive_yaml=(not options.no_archive_yaml))




if __name__ == '__main__':
    run()