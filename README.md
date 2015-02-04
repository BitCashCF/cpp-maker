maker
=====

Maker is a prototyping build system that adds a simple layer between CMake and your project. The design goal is to make setting up PoC and hobby project extremely fast, even when the project consists of several interdepending libraries and applications.

There is no real documentation, but a test project with the most important use cases exemplified

Nomenclature:
* module - a single sub project, there are several types (app/lib/protocol as of time of writing) all with special behaviour.

Some important things to consider:
* module (app/lib/protocol) name is implicit from directory structure. 
* There needs to be one makerfile/module and it should be placed in the modules root folder
* Modules must be places in \<project root\>/\<module type\>s/\<module name\>
* for libs, you need to place external includable headers in include sub folder, and source in src sub folder 
* tests are autmatically added when you have a sub folder gstests in your module

So use this if you want to play around and quickly form a project, especially using boost and or protobuf (since it's built into the build system). Use something more advanced (like CMake directly, autotools etc) when you need more control over the output.

Please see the wiki (https://github.com/meros/cpp-maker/wiki) for more information
