maker
=====

Maker is a build system that adds a simple layer between CMake and the project.

Please see testproject for an example of all currently implemented features.

Some important things to consider:
* module (app/lib) name is implicit from directory structure
* external include files in libs should be places in sub folder include
* modules are always defined in a file named makerfile
* tests are autmatically added when you have a sub folder gstests in your module
