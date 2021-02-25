program DDS_SIM;

uses
  Forms,
  DDS_SIM_MainForm in 'DDS_SIM_MainForm.pas' {Form6};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm6, Form6);
  Application.Run;
end.
