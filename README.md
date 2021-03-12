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

### Source code 
A Windows installer is provided for ordinary users. Those who wish to compile TDF from source code, the Visual Studio "Publish" method is not used. Instead, the TDF installer program is created using Inno Setup. In addition to Visual Studio, the development Windows PC should also have these installed:
- [Inno Setup](https://jrsoftware.org/isinfo.php): When Visual Studio is instructed to "build" TDF, a post-build step invokes Inno Setup whcih will package the necessary files such as executables, icons and other resources into an installer program. The end user executes this program on their Windows PC to set up TDF on the target computer. 
- [Inno Download Plugin (IDP)](https://mitrichsoftware.wordpress.com/inno-setup-tools/inno-download-plugin/): When creating the installer program, Inno Setup (above) will use IDP to make the installer capable of checking required Microsoft .Net Framework version. If it is absent on the target Windows computer, with IDP, it will be installed automatically, provided that an Internet connection is available on that computer. 
