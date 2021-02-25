unit DDS_SIM_MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, SLCommonFilter, SLGenericInt, SLGenericReal,
  SLStreamTypes, SLComponentCollection, LPDrawLayers, SLScope, SLCommonGen,
  SLGenericIntGen, SLFourier, ActnList, StdActns, PlatformDefaultStyleActnCtrls,
  ActnMan, XPMan, ToolWin, ActnCtrls, ActnMenus, ExtCtrls, LPComponent,
  VCL.LPControl, SLControlCollection, LPControlDrawLayers;

type
  TForm6 = class(TForm)
    SLGenericIntGen1: TSLGenericIntGen;
    SLFourier1: TSLFourier;
    ActionMainMenuBar1: TActionMainMenuBar;
    XPManifest1: TXPManifest;
    ActionManager1: TActionManager;
    FileExit1: TFileExit;
    Panel1: TPanel;
    Panel2: TPanel;
    SLScope1: TSLScope;
    SLScope2: TSLScope;
    LabeledEdit1: TLabeledEdit;
    Splitter1: TSplitter;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    procedure SLGenericIntGen1Start(Sender: TObject; SampleRate: Real);
    procedure SLGenericIntGen1Stop(Sender: TObject);
    procedure SLGenericIntGen1Generate(Sender: TObject;
      var OutBuffer: ISLIntegerBuffer; var Populated, Finished: Boolean);
    procedure LabeledEdit1Change(Sender: TObject);
    procedure LabeledEdit2Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}

var ii: integer;

var
  dds_accumulator: integer;
  dds_phase_increment: integer = 30000;

procedure TForm6.FormShow(Sender: TObject);
begin
  dds_phase_increment := strtoint(labelededit1.Text);
  SLGenericIntGen1.SampleRate := strtoint(labelededit2.Text);
  SLGenericIntGen1.Stop;
  SLGenericIntGen1.Start;

end;

procedure TForm6.LabeledEdit1Change(Sender: TObject);
begin
  //
  dds_phase_increment := strtoint(labelededit1.Text);
end;

procedure TForm6.LabeledEdit2Change(Sender: TObject);
var
  f: integer;
begin
  f := strtoint(labelededit2.Text);
  SLGenericIntGen1.SampleRate := f;
  SLGenericIntGen1.Stop;
  SLGenericIntGen1.Start;
end;

procedure TForm6.SLGenericIntGen1Generate(Sender: TObject;
  var OutBuffer: ISLIntegerBuffer; var Populated, Finished: Boolean);
var
  I : Integer;
  ph: integer;
  si: real;
begin
  //
  for I := 0 to 8096 - 1 do
  begin
    dds_accumulator := dds_accumulator + dds_phase_increment;
    ph := (dds_accumulator shr 16) and $FF;
    si := sin(2*pi * ( ph/256));

    OutBuffer.Items[I] := trunc(si*100);

    //OutBuffer.Items[I] := (ph and 1) * 100;

  end;


end;

procedure TForm6.SLGenericIntGen1Start(Sender: TObject; SampleRate: Real);
begin
  //
end;

procedure TForm6.SLGenericIntGen1Stop(Sender: TObject);
begin
  //
end;

end.
