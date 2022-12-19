import parser_cfg
import os
import sys

class uvm_autogen():
    def __init__(self):
        self.out_dir
        self.module_name=""
        self.paser_cfg=parser_cfg()


    def build_dir(self):
        os.chdir(self.out_dir)#change into the project dir
        if not path_exists("bin"):
            os.mkdir("bin")
        if not path_exists("cov"):
            os.mkdir("cov")
        if not path_exists("env"):
            os.mkdir("env")
        if not path_exists("filelist"):
            os.mkdir("filelist")
        if not path_exists("seq"):
            os.mkdir("seq")
        if not path_exists("test"):
            os.mkdir("test")
        if not path_exists("top"):
            os.mkdir("top")
        return
    def run_flow(self):
        self.build_dir


if __name__ == '__main__':
    aaa.build_dir()