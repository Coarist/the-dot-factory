<p align="left">
  <img src="https://github.com/Coarist/the-dot-factory/blob/master/TheDotFactory/Logo1Small.png?raw=true" width="120" title="Visual Studio project properties">
</p>

# The Dot Factory - TDF 
Generates fonts for dot matrix displays. This repo is forked from [Pavius](https://github.com/pavius/the-dot-factory). Eran Duchan provided [A tech journal](http://www.eran.io/the-dot-factory-an-lcd-font-and-image-generator/). On 15 March 2021 [binary v.1.1](https://github.com/Coarist/the-dot-factory/releases/tag/v.1.1) is released.

### Contributing
**TDF** is currently stable, unmaintained and not accepting PRs (as I don't have the time to thoroughly test contributions). 
If your fork has a working, substantial feature - kindly submit a PR to the README with a short description and link.

### This fork 
This code repository is forked from the original (see http link above) with the intention that the changes and improvements made here could back-propagate to the original version. Key changes:
- Windows 10: The master from which this version is forked already works in Windows 10. This version explicitly states that it should work on the Windows 10 platform. 
- Micrososft Visual Studio 2019 (VS2019): code editing and build tool using up-to-date IDE
- A program icon is designed for **TDF**, and it is given to **TDF** to enhance product identity.
- Installer: with this version, **TDF** can now distribute to the end user by providing a better installer. 
- Faster execution - when generating larger outputs, operation feels noticably speedier.

Source code is written on the **Microsoft .NET Framework** and the graphical user interface is based on WinForms. **TDF** can be ported to other prevalent operating system such as MacOS and Linux using, for example, Mono. The focus of this repo at this point of time remains in the domain of the Windows PC. 

### Obtaining TDF 
Windows installer [binary v.1.1](https://github.com/Coarist/the-dot-factory/releases/tag/v.1.1) is available. This file is also duplicated and accessible in this repo: [TheDotFactorySetup.exe](https://github.com/Coarist/the-dot-factory/blob/master/TheDotFactory/Output). **TDF** can be quickly set up and run by downloading the installer program and executing it on the user's PC computer. 

### Build from source code 
Developers who wish to compile **TDF** from source code, the Visual Studio "Publish" method can be used to generate the installer program. However, a more satisfactory method will be to create an **TDF** installer program using *Inno Setup*. To build **TDF** from source code, the development Windows PC should have these installed:
- [Microsoft Visual Studio](https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=Community&rel=16): current version is VS2019. 
- [.NET Framework 3.5](https://docs.microsoft.com/en-us/dotnet/framework/install/dotnet-35-windows-10) (Windows 10 would have included it. If that is the case on the development computer, this pre-requisit is satisfied and this step will not be necessary.) 

With the items above, the **TDF** program should build successfully. Additionally, a post-build step is inserted in the Visual Studio project to further process the build results and finally create a proper installer program for **TDF**. The development Windows PC should have these also installed:

- [Inno Setup](https://jrsoftware.org/isinfo.php): When Visual Studio is instructed to "build" **TDF**, a post-build step invokes *Inno Setup* which will package the necessary files such as executables, icons and other resources into an installer program - the "distributable". The end user executes this program on their Windows PC to set up **TDF** on the target computer. 
- [Inno Download Plugin (IDP)](https://mitrichsoftware.wordpress.com/inno-setup-tools/inno-download-plugin/): When creating the installer program, *Inno Setup* (above) will use IDP to make the installer capable of checking required Microsoft .NET Framework. If it is absent on the target Windows computer, IDP will automatically attempt downloading and installing, provided that an Internet connection is available on that computer. 

### Additional configurations
The Visual Studio project has added automation to generate a Windows installer when build configuration is "Release". The local PC would have *Inno Setup* and *Inno Download Plugin* (above) installed. The developer who wish to build this installer would need to specify the correct path to these tools on the local machine in two places. The steps to do so are printed below. 

In Visual Studio, go to Solution Explorer pane. Right click "TheDotFactory" and in the context menu select "Properties". 

<p align="left">
  <img src="https://github.com/Coarist/the-dot-factory/blob/master/SlnExplr.JPG?raw=true" width="350" title="Visual Studio project properties">
</p>

The screenshot below will be displayed. 

### Path to Inno Setup executable 
The path to *Inno Setup* needs to be updated by the developer to reflect the correct location on his/her development PC (see text in yellow highlighter). This concludes the first step. 

<p align="left">
  <img src="https://github.com/Coarist/the-dot-factory/blob/master/Properties.JPG?raw=true" width="350" title="Visual Studio project properties">
</p>

### Path to Inno Download Plugin 
In our second step, the path to *Inno Download Plugin* would need to be specifled correctly. Refer to the first screen shot above showng the Visual Studio Solution Explorer, right-click the item "TDF_InnoScript.iss" and in the context menu click "Open". The contents of this file will be shown on the editor pane. 

<p align="left">
  <img src="https://github.com/Coarist/the-dot-factory/blob/master/iss.JPG?raw=true" width="350" title="Visual Studio project properties">
</p>

The path to *Inno Download Plugin* needs to be updated by the developer to reflect the correct location on his/her development PC (text in yellow highlighter). This would be the second and last step. 

### Build TheDotFactory 
When configured correctly in Visual Studio, the developer may try out "Build"-ing **TDF** using the "Relesase" project configuration. Observe that after a successful build, a new Windows File Explorer window will be shown. The window shows the **TDF** installer program that has just been created. The "modified date and time" of this file can be checked against the build time and date. This verifies that the post-build step has been executed to completion. The "Output" pane in Visual Studio can be inspected to see detail messages generated during this step. 
