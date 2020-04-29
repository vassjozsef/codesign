Code Sign
=========

Sample code to check signature of OSX application.

Build
-----

    clang -std=c11 -framework CoreFoundation -framework Security codesign.m

Resources
---------

https://opensource.apple.com/source/security_systemkeychain/security_systemkeychain-55202/src/cs_dump.cpp.auto.html
https://stackoverflow.com/questions/49563587/c-macos-programmatically-retrieve-code-sign-certificate-information
https://developer.apple.com/library/archive/technotes/tn2206/_index.html
https://developer.apple.com/library/archive/documentation/Security/Conceptual/CodeSigningGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40005929-CH1-SW1
