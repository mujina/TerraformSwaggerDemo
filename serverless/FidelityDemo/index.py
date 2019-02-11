import sys
import os
import json

base_dir = os.path.dirname(__file__) or '.'
sys.path.insert(0, base_dir)

def handler(event, context):
    environment = os.getenv('ENVIRONMENT', 'test')
    system_code = os.getenv('SYSTEM_CODE', 'fidelity_demo')


    return {'statusCode': 200,
            'body': '{ "result": "OK" }',
            'headers': {'Content-Type': 'application/json'}}

if __name__ == "__main__":
    with open('./TestData/test_data.json') as f:
        content = f.read()
    parsed_event = eval(content)
    result = handler(parsed_event, {})
    print(result)