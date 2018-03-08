from configparser import ConfigParser
from fire import Fire

class Config():

    def __init__(self, config_file_path='config.ini'):
        self.config = ConfigParser()
        self.config.read(config_file_path)
    
    def get(self, field, key):
        result = ""  
        try:  
            result = self.config.get(field, key)  
        except:  
            result = ""  
        return result  
    
    def set(self, field, key ,value):
        try:  
            self.config.set(field, key, value)  
            self.config.write(open(self.path,'w'))  
        except:
            return False
        return True

    def __getattr__(self, item):
        return getattr(self.config, item)

def main():
    config = Config()
    Fire(config)

if __name__ == '__main__':
    main()