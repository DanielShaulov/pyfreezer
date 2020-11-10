# pyfreezer
Freezes python programs to a single ELF, with no external dependencies, by using the built-in freeze.py and frozen modules utilities.  
Unlike pyinstaller, this doesn't rely on unpacking files to a temporary directory and just runs from memory.  
This will produce a binary that only depends on libc, and doesn't need a high version (usually libc2.11, it prints the needed version)

An alternative (much better supported) project that achieves similar goals (but with much more complex code) is [PyOxidizer](https://github.com/indygreg/PyOxidizer)

## Usage
Load the directory that contains your app as a volume for the docker, then pass the "main" file as a parameter.  
There must be a `requirements.txt` file near your main with dependancies (can be empty).  
The output will be placed at the same directory as the "main" file, with the same name but without the `.py` extension
```bash
docker run -v ${PWD}/example:/code danielshaulov/pyfreezer:latest /code/example.py
./example/example
```

## Knonw Issues
Any module that uses `__file__` to look for resource near the module will fail (since it runs from memory, there is no `__file__`)
Some modules have support for "package resources" instead of using `__file__` but pyfreezer doesn't support that (yet)

### Certifi
A known culprit is `cetifi` used by `requests`, to "fix" it you can add the following snippet to your code, before importing anything:
```python
import certifi
certifi.where = lambda: ""
```
This will override the function that looks for the certificate file with a function that returns an empty string.  
It works fine for making requests that are not `https`, and for `https` requests with `verify=False`.  
If you need SSL verification - you will need to provide a path to `ca` file in that `lambda`, or pass the path to `verify`.  
