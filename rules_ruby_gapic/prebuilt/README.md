A set of prebuilt rubys so that the ruby_runtime rule does not have to rebuild ruby binaries every time.  
Used to speed up builds of client libraries.  
  
The check for a prebuild viability goes as follows:  
* The name of the file contains the current machine's architecture  
* If we extract the file we can run a complicated ruby command that requires multiple standard libraries
and then executes a script inline  

If prebuild does not pass the test it is discarded.  
If no prebuilds work the rule builds its own ruby.  

The prebuilds have to be mentioned by name in the ruby_runtime rule invocation.  

The small script provided shows how to pack a prebuild from a ruby_runtime rule results.