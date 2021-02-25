unit SDRMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Mitov.Types, SLCommonGen, SLSignalGen,
  Mitov.VCLTypes, VCL.LPControl, SLControlCollection, LPControlDrawLayers,
  SLBasicDataDisplay, SLDataDisplay, SLDataChart, SLScope, SLMultiInput,
  SLMultiply, LPComponent, SLCommonFilter, SLSimpleFilter, SLFrequencyFilter,
  SLLowPass, TLBasicTimingFilter, TLClockGen, SLAdd, Vcl.StdCtrls, Vcl.Buttons,
  SLBasicAnalysis, SLRMSMeter, SLSubtract, SLFourier, SLAverageValue;

type
  TForm2 = class(TForm)
    SLScope1: TSLScope;
    LO_I: TSLSignalGen;
    LO_Q: TSLSignalGen;
    SLScope2: TSLScope;
    signal: TSLSignalGen;
    MIX_I: TSLMultiply;
    MIX_Q: TSLMultiply;
    LP_I: TSLLowPass;
    LP_Q: TSLLowPass;
    refclock: TTLClockGen;
    MIX2_I: TSLMultiply;
    MIX2_Q: TSLMultiply;
    sumout: TSLAdd;
    WO_I: TSLSignalGen;
    WO_Q: TSLSignalGen;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    lblF: TLabel;
    SLScope3: TSLScope;
    SLFourier1: TSLFourier;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
  signal.Frequency := signal.Frequency + 50;
  lblF.Caption := IntToStr(trunc(signal.Frequency));

end;

procedure TForm2.BitBtn2Click(Sender: TObject);
begin
  signal.Frequency := signal.Frequency - 50;
  lblF.Caption := IntToStr(trunc(signal.Frequency));

end;

end.
