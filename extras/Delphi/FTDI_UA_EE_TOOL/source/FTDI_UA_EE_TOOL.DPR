program FTDI_UA_EE_TOOL;

uses
  Forms,
  Main in 'Main.pas' {Form1},
  CfgUnit in 'CfgUnit.pas' {SetupForm},
  D2XXUnit in 'D2XXUnit.pas',
  About in 'About.pas' {Aboutform};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TSetupForm, SetupForm);
  Application.CreateForm(TAboutform, Aboutform);
  Application.Run;
end.
