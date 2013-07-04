maker
=====

Maker is a prototyping build system that adds a simple layer between CMake and the project. The design goal is to make setting up PoC and hobby project extremely fast. Creating a project fropm scratch with a handful of apps and libs and tests should only take a few minutes from idea to build.

Please see testproject for an example of all currently implemented features (no protobud protocols in there yet).

Some important things to consider:
* module (app/lib/protocol) name is implicit from directory structure
* external include files in libs should be places in sub folder include
* modules are always defined in a file named makerfile
* tests are autmatically added when you have a sub folder gstests in your module

So use this if you want to play around and quickly form a project. Use something more advanced (like CMake, autotools etc) when you need more control over the output.
