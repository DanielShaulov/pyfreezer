print("Hello World!")

import sys
print(sys.path, sys.executable, sys.prefix)

import cryptography
import certifi
certifi.where = lambda: ""
import requests
