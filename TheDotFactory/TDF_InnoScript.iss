;-----------------------------------------------------------------------------
; Pre-requisite detect, auto-download and auto-install
;    detection:     v1.1 - v4.7.2
;    auto-download: v4.0 - v4.7.2
; Special annotation for v4.0, it is NOT specified as 'v4.0'. It is to be:
;    v4\Client
;    v4\Full
;-----------------------------------------------------------------------------

;-----------------------------------------------------------------------------
; https://mitrichsoftware.wordpress.com/inno-setup-tools/inno-download-plugin/
; Inno Download Plugin for auto-detect and install require .NET Framework
;-----------------------------------------------------------------------------
;#include <idp.iss>
#include "D:\Program Files (x86)\Inno Download Plugin\idp.iss"

;-----------------------------------------------------------------------------
; Per-application-program parameters
;-----------------------------------------------------------------------------
#define MyAppName "The Dot Factory"
#define MyAppVersion "1.1"
#define MyAppPublisher "nohows"
#define MyAppURL "https://github.com/Coarist/the-dot-factory/wiki"
#define MyAppExeName "TheDotFactory.exe"
#define MyDistFolder "F:\Documents\Visual Studio 2019\UartSniff3\UartSniff3\bin\Release"
#define MyPrequisiteDotNetFramework "v3.5"
#define MyDotNetTmpFileName "TDF_Setup.exe"

#define MICROSOFTURL "https://go.microsoft.com/fwlink/?LinkId="
;-----------------------------------------------------------------------------
;https://docs.microsoft.com/en-us/previous-versions/dotnet/netframework-4.0/5a4x27ek(v=vs.100)
; Section "Web Bootstrapper Packages"
;-----------------------------------------------------------------------------
#define LINKID_4_0_FULL   "181011"
#define LINKID_4_0_CLIENT "181012"

;-----------------------------------------------------------------------------
; https://docs.microsoft.com/en-us/dotnet/framework/deployment/deployment-guide-for-developers
; Section "Redistributable Packages", column "Web installer"
;-----------------------------------------------------------------------------
#define LINKID_4_5   "225704" 
#define LINKID_4_5_1 "322115" 
#define LINKID_4_5_2 "397707" 
#define LINKID_4_6   "528222" 
#define LINKID_4_6_1 "671728" 
#define LINKID_4_6_2 "780596" 
#define LINKID_4_7   "825298" 
#define LINKID_4_7_1 "852092" 
#define LINKID_4_7_2 "863262" 

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{C94BEF56-95D6-4153-AFF2-38CB6C477D6E}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
LicenseFile=G:\Documents\VisualStudio\the-dot-factory\TheDotFactory\bin\Release\LICENSE.txt
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputBaseFilename=TheDotFactorySetup
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "G:\Documents\VisualStudio\the-dot-factory\TheDotFactory\bin\Release\TheDotFactory.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "G:\Documents\VisualStudio\the-dot-factory\TheDotFactory\bin\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[Code]
;-----------------------------------------------------------------------------
; https://docs.microsoft.com/en-us/dotnet/framework/deployment/deployment-guide-for-developers
; Section "Detecting the .NET Framework"
;-----------------------------------------------------------------------------
function IsDotNetDetected(version: string; service: cardinal): boolean;
; Indicates whether the specified version and service pack of the .NET Framework is installed.
;
; version -- Specify one of these strings for the required .NET Framework version:
;    'v1.1'          .NET Framework 1.1
;    'v2.0'          .NET Framework 2.0
;    'v3.0'          .NET Framework 3.0
;    'v3.5'          .NET Framework 3.5
;    'v4\Client'     .NET Framework 4.0 Client Profile
;    'v4\Full'       .NET Framework 4.0 Full Installation
;    'v4.5'          .NET Framework 4.5
;    'v4.5.1'        .NET Framework 4.5.1
;    'v4.5.2'        .NET Framework 4.5.2
;    'v4.6'          .NET Framework 4.6
;    'v4.6.1'        .NET Framework 4.6.1
;    'v4.6.2'        .NET Framework 4.6.2
;    'v4.7'          .NET Framework 4.7
;    'v4.7.1'        .NET Framework 4.7.1
;    'v4.7.2'        .NET Framework 4.7.2
;
; service -- Specify any non-negative integer for the required service pack level:
;    0               No service packs required
;    1, 2, etc.      Service pack 1, 2, etc. required
var
    key, versionKey: string;
    install, release, serviceCount, versionRelease: cardinal;
    success: boolean;
begin
    versionKey := version;
    versionRelease := 0;

    ; .NET 1.1 and 2.0 embed release number in version key
    if version = 'v1.1' then begin
        versionKey := 'v1.1.4322';
    end else if version = 'v2.0' then begin
        versionKey := 'v2.0.50727';
    end

    ; .NET 4.5 and newer install as update to .NET 4.0 Full
    else if Pos('v4.', version) = 1 then begin
        versionKey := 'v4\Full';
        case version of
          'v4.5':   versionRelease := 378389;
          'v4.5.1': versionRelease := 378675; // 378758 on Windows 8 and older
          'v4.5.2': versionRelease := 379893;
          'v4.6':   versionRelease := 393295; // 393297 on Windows 8.1 and older
          'v4.6.1': versionRelease := 394254; // 394271 before Win10 November Update
          'v4.6.2': versionRelease := 394802; // 394806 before Win10 Anniversary Update
          'v4.7':   versionRelease := 460798; // 460805 before Win10 Creators Update
          'v4.7.1': versionRelease := 461308; // 461310 before Win10 Fall Creators Update
          'v4.7.2': versionRelease := 461808; // 461814 before Win10 April 2018 Update
        end;
    end;

    ; installation key group for all .NET versions
    key := 'SOFTWARE\Microsoft\NET Framework Setup\NDP\' + versionKey;

    ; .NET 3.0 uses value InstallSuccess in subkey Setup
    if Pos('v3.0', version) = 1 then begin
        success := RegQueryDWordValue(HKLM, key + '\Setup', 'InstallSuccess', install);
    end else begin
        success := RegQueryDWordValue(HKLM, key, 'Install', install);
    end;

    ; .NET 4.0 and newer use value Servicing instead of SP
    if Pos('v4', version) = 1 then begin
        success := success and RegQueryDWordValue(HKLM, key, 'Servicing', serviceCount);
    end else begin
        success := success and RegQueryDWordValue(HKLM, key, 'SP', serviceCount);
    end;

    ; .NET 4.5 and newer use additional value Release
    if versionRelease > 0 then begin
        success := success and RegQueryDWordValue(HKLM, key, 'Release', release);
        success := success and (release >= versionRelease);
    end;

    result := success and (install = 1) and (serviceCount >= service);
end;

;-----------------------------------------------------------------------------
; This funciton get called automatically
;-----------------------------------------------------------------------------
function InitializeSetup(): Boolean;
begin
    if Not IsDotNetDetected('{#MyPrequisiteDotNetFramework}', 0) then begin
        MsgBox('{#MyAppName} requires Microsoft .NET Framework {#MyPrequisiteDotNetFramework}.'#13#13
          'This installer program will attempt to download and install it.', mbInformation, MB_OK);
    end;
    result := true;
end;

procedure InitializeWizard();
var 
    downloadLink: string;
    fail: boolean;
begin
    if not IsDotNetDetected('{#MyPrequisiteDotNetFramework}', 0) then begin

        fail := false;

        if '{#MyPrequisiteDotNetFramework}' = 'v4\Client' then begin
            downloadLink := '{#MICROSOFTURL}' + '{#LINKID_4_0_CLIENT}'
        end else
        if '{#MyPrequisiteDotNetFramework}' = 'v4\Full' then begin
            downloadLink := '{#MICROSOFTURL}' + '{#LINKID_4_0_FULL}'
        end else
        if '{#MyPrequisiteDotNetFramework}' = 'v4.5' then begin
            downloadLink := '{#MICROSOFTURL}' + '{#LINKID_4_5}'
        end else
        if '{#MyPrequisiteDotNetFramework}' = 'v4.5.1' then begin
            downloadLink := '{#MICROSOFTURL}' + '{#LINKID_4_5_1}'
        end else
        if '{#MyPrequisiteDotNetFramework}' = 'v4.5.2' then begin
            downloadLink := '{#MICROSOFTURL}' + '{#LINKID_4_5_2}'
        end else
        if '{#MyPrequisiteDotNetFramework}' = 'v4.6' then begin
            downloadLink := '{#MICROSOFTURL}' + '{#LINKID_4_6}'
        end else
        if '{#MyPrequisiteDotNetFramework}' = 'v4.6.1' then begin
            downloadLink := '{#MICROSOFTURL}' + '{#LINKID_4_6_1}'
        end else
        if '{#MyPrequisiteDotNetFramework}' = 'v4.6.2' then begin
            downloadLink := '{#MICROSOFTURL}' + '{#LINKID_4_6_2}'
        end else
        if '{#MyPrequisiteDotNetFramework}' = 'v4.7' then begin
            downloadLink := '{#MICROSOFTURL}' + '{#LINKID_4_7}'
        end else
        if '{#MyPrequisiteDotNetFramework}' = 'v4.7.1' then begin
            downloadLink := '{#MICROSOFTURL}' + '{#LINKID_4_7_1}'
        end else
        if '{#MyPrequisiteDotNetFramework}' = 'v4.7.2' then begin
            downloadLink := '{#MICROSOFTURL}' + '{#LINKID_4_7_2}'
        end else begin
            fail := true;
            MsgBox('{#MyAppName} requires Microsoft .NET Framework {#MyPrequisiteDotNetFramework}.'#13#13
               'This installer program does not support downloading lower than .NET Framework 4.0.', mbInformation, MB_OK);
        end;

        if not fail then begin
            idpAddFile(downloadLink, ExpandConstant('{tmp}\{#MyDotNetTmpFileName}'));
            idpDownloadAfter(wpReady);
        end;
    end;
end;

procedure InstallFramework;
var
  StatusText: string;
  ResultCode: Integer;
begin
  StatusText := WizardForm.StatusLabel.Caption;
  WizardForm.StatusLabel.Caption := 'Installing .NET Framework {#MyPrequisiteDotNetFramework}. This might take a few minutes…';
  WizardForm.ProgressGauge.Style := npbstMarquee;
  try
    if not Exec(ExpandConstant('{tmp}\NetFrameworkInstaller.exe'), '/passive /norestart', '', SW_SHOW, ewWaitUntilTerminated, ResultCode) then
    begin
      MsgBox('.NET installation failed with code: ' + IntToStr(ResultCode) + '.', mbError, MB_OK);
    end;
  finally
    WizardForm.StatusLabel.Caption := StatusText;
    WizardForm.ProgressGauge.Style := npbstNormal;

    DeleteFile(ExpandConstant('{tmp}\{#MyDotNetTmpFileName}'));
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  case CurStep of
    ssPostInstall:
      begin
        if not IsDotNetDetected('{#MyPrequisiteDotNetFramework}', 0) then
        begin
          InstallFramework();
        end;
      end;
  end;
end;



