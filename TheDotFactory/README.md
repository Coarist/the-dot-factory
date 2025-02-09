# The Dot Factory
Generates fonts for dot matrix displays. Read more and download binaries [here](http://www.eran.io/the-dot-factory-an-lcd-font-and-image-generator/).

### Contributing
TDF is currently stable, unmaintained and not accepting PRs (as I don't have the time to thoroughly test contributions). 
If your fork has a working, substantial feature - kindly submit a PR to the README with a short description and link.

### This fork 
This code repository is forked from the original (see http link above) with the intention that the changes and improvements made here could back-propagate to the original version. Key changes:
- Windows 10: The master from which this version is forked already works on the Windows 10. This version explicitly states that it should work on the Windows 10 platform. 
- Micrososft Visual Studio 2019 (VS2019): code editing and build tool using up-to-date IDE
- A program icon is designed for TDF, and it is added to enhance the identity of TDF.
- Installer: with this version, TDF can now distribute to the end user by providing a better installer. 

TDF is Windows-only. Source code is written on the Microsoft .NET Framework and using WinForms. 

### Build from source code 
A Windows installer is provided for ordinary users. Those who wish to compile TDF from source code, the Visual Studio "Publish" method can be used to generate the installer program. However, a more satisfactory method will be to create an TDF installer program using Inno Setup. To build TDF from source code, the development Windows PC should have these installed:
- [Microsoft Visual Studio](https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=Community&rel=16): current version is VS2019. 
- [.NET Framework 3.5](https://docs.microsoft.com/en-us/dotnet/framework/install/dotnet-35-windows-10) (Windows 10 would have included it. If that is the case on the development computer, this pre-requisit is satisfied and no installation step is needed for this)
- [Inno Setup](https://jrsoftware.org/isinfo.php): When Visual Studio is instructed to "build" TDF, a post-build step invokes Inno Setup which will package the necessary files such as executables, icons and other resources into an installer program - the "distributable". The end user executes this program on their Windows PC to set up TDF on the target computer. 
- [Inno Download Plugin (IDP)](https://mitrichsoftware.wordpress.com/inno-setup-tools/inno-download-plugin/): When creating the installer program, Inno Setup (above) will use IDP to make the installer capable of checking required Microsoft .Net Framework version. If it is absent on the target Windows computer, with IDP, it will be installed automatically, provided that an Internet connection is available on that computer. 
