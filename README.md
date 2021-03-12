# The Dot Factory
Generates fonts for dot matrix displays. Read more and download binaries [here](http://www.eran.io/the-dot-factory-an-lcd-font-and-image-generator/).

### Contributing
TDF is currently stable, unmaintained and not accepting PRs (as I don't have the time to thoroughly test contributions). 
If your fork has a working, substantial feature - kindly submit a PR to the README with a short description and link.

### This version 
This code repository is a version forked from the original (see http link above) with the intention that the changes and improvements made here could back-propagate to the original version. Key changes:
- Windows 10: explicitly state that this version works on the Windows 10 platform
- VS2019: code editing and build tool using up-to-date IDE
- Icon is added to enhance the identity of the TDF.
- Installer: with this version, TDF will now ship to the end user with a proper installer. 
TDF is Windows-only mainly due to it being written on the Microsoft .NET Framework and more due to using WinForms. 
