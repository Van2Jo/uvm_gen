import configparser
import os
import argparse
import logging

#agent
class agent_section():
    def __init__(self):
        self.name = ""
        self.is_active=0
        self.agent_list_num=0

class parser_cfg(object):
    def __init__(self):
        self.cfg_file_path="..\Excel"
        self.conf = configparser.ConfigParser()
        #top config
        #self.top_dic={}
        self.module_name=""
        self.clk_cycle=1          # ns
        self.rst_delay=1          # ns
        self.vip=""
        self.num_master=0
        self.num_slave=0
        self.num_agent=0
        #master
        self.master_dic={"addr_width":1,"data_width":1,"id_width":1}
        #slave
        self.slave_dic = {"addr_width":1,"data_width":1,"id_width":1}
        #agent
        self.agents =[]       ##null list, element is agent class
    def get_cfg_path(self):
        parser = argparse.ArgumentParser(description=uvmcodegen_description)
        parser.add_argument('-cfg_path', type=str, help='config path', default='./')
        args = parser.parse_args()
        self.cfg_file_path = args.cfg_path

    def parser_top_section(self):

        #parser top
        cfg_options = self.conf.options("top")
        print(f"2所有options：{cfg_options}")
        #module
        if self.conf.has_option("top","module"):
            self.module_name = self.conf.get("top","module")
        if self.conf.has_option("top", "vip"):
            self.vip = self.conf.get("top", "vip")
        #num_master
        if self.conf.has_option("top","num_master"):
            self.num_master = self.conf.get("top","num_master")
        #num_slave
        if self.conf.has_option("top","num_slave"):
            self.num_slave = self.conf.get("top","num_slave")
        #is_active
        if self.conf.has_option("top","is_active"):
            self.is_active = self.conf.get("top","is_active")
        #num_agent
        if self.conf.has_option("top","num_agent"):
            self.num_agent = self.conf.get("top","num_agent")
            print("num_agent:"+self.num_agent)


    def parser_master_section(self):
        section_name = "master"
        #
        if self.conf.has_option(section_name,"addr_width"):
            self.master_dic["addr_width"] = self.conf.get(section_name,"addr_width")
        if self.conf.has_option(section_name, "data_width"):
            self.master_dic["data_width"] = self.conf.get(section_name,"data_width")
        if self.conf.has_option(section_name,"id_width"):
            self.master_dic["id_width"] = self.conf.get(section_name,"id_width")

    def parser_slave_section(self):
        section_name = "slave"
        #
        if self.conf.has_option(section_name, "addr_width"):
            self.slave_dic["addr_width"] = self.conf.get(section_name, "addr_width")
        if self.conf.has_option(section_name, "data_width"):
            self.slave_dic["data_width"] = self.conf.get(section_name, "data_width")
        if self.conf.has_option(section_name, "id_width"):
            self.slave_dic["id_width"] = self.conf.get(section_name, "id_width")
    #parser agent section
    def parser_agents_section(self):
        my_agent = agent_section()
        num_agent = int(self.num_agent)
        for x in range(num_agent):
            agent_sec = "agent_"+str(x)
            print("agent_sec name:"+agent_sec)
            if self.conf.has_option(agent_sec, "name"):
                my_agent.name = self.conf.get(agent_sec, "name")
            if self.conf.has_option(agent_sec, "is_active"):
                my_agent.is_active = self.conf.get(agent_sec, "is_active")
            if self.conf.has_option(agent_sec, "agent_list_num"):
                my_agent.agent_list_num = self.conf.get(agent_sec, "agent_list_num")
            self.agents.append(my_agent)

    def parser(self):
        print(os.path.join(self.cfg_file_path, "config.conf"))
        self.conf.read(os.path.join(self.cfg_file_path,"config.conf"))

        print(f"2、获取mysqldb所有的options:{self.conf.sections()}")
        cfg_sections = self.conf.sections()
        if self.conf.has_section("top"):
            self.parser_top_section()

        print("num_master:"+self.num_master)
        if self.num_master != 0:
            if(self.conf.has_section("master")):
                self.parser_master_section()
            else:
                logging.error("ERROR: no find master section")

        if self.num_slave != 0:
            if(self.conf.has_section("slave")):
                self.parser_slave_section()
            else:
                logging.error(" no find slave section")
        if self.num_agent != 0:
            self.parser_agents_section()

if __name__ == '__main__':
    pas_cfg = parser_cfg()
    pas_cfg.parser()