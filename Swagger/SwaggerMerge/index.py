import os
import glob
import sys
import json
import yaml

class SwaggerMerger:

    def __init__(self):
        self.function_root = "."
        self.debug = True
        self.global_config = {}
        self.environment = os.getenv("ENVIRONMENT")\
            or fatal('Environment not defined')

    def get_check(self, check_name):
        return self.client.get_check(check_name)

    def load_check_config(self):
        with open('checks.json') as f:
            self.check_config = json.load(f)


    def load_global_swag(self):
        with open('../swagger.yaml', 'r') as f:
            try:
                self.global_yaml = yaml.load(f)
            except yaml.YAMLError as e:
                self.fatal(e)

        self.global_yaml['paths'] = {}

        print(self.global_yaml)


    def get_function_swags(self):
        function_swags = glob.glob("../../serverless/*/swagger.yaml")
        for swag in function_swags:
            with open(swag, 'r') as f:
                try:
                    local_yaml = yaml.load(f)
                except yaml.YAMLError as e:
                    self.fatal(e)

            for key in local_yaml['paths'].keys():
                self.global_yaml['paths'][key] = local_yaml['paths'][key]

        print(yaml.dump(self.global_yaml))

    def write_output_file(self):
        with open('../swagger-merged.yaml', 'w') as f:
            yaml.dump(self.global_yaml, f)

    def main(self):
        self.load_global_swag()
        self.get_function_swags()
        self.write_output_file()


if __name__ == "__main__":
    swagger_merger = SwaggerMerger()
    swagger_merger.main()