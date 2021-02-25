unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ImgList, ToolWin, ComCtrls, StdCtrls, ExtCtrls, ActnList, Buttons,
  Vcl.StdActns, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.ActnCtrls,
  Vcl.ActnMenus;


type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Memo1: TMemo;
    Timer1: TTimer;
    ListView1: TListView;
    ActionManager1: TActionManager;
    FileOpen1: TFileOpen;
    FileSaveAs1: TFileSaveAs;
    FileExit1: TFileExit;
    ActionMainMenuBar1: TActionMainMenuBar;
    Action1: TAction;
    Action2: TAction;
    Memo2: TMemo;
    Action3: TAction;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FTSendFileExecute(Sender: TObject);
    procedure FTQuitExecute(Sender: TObject);
    procedure ListView1Click(Sender: TObject);
    procedure FileOpen1Accept(Sender: TObject);
    procedure FileSaveAs1Accept(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
  private
    { Private declarations }
    lastval: byte;

    procedure ee_CS(value: integer);
    procedure ee_SCL(value: integer);
    procedure ee_MOSI(value: integer);
    function  ee_MISO: integer;

    procedure spi_CS(value: integer);
    procedure spi_SCL(value: integer);
    procedure spi_MOSI(value: integer);
    function  spi_MISO: integer;
    function  spi_xfer(value: byte): byte;



  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  D2XXUnit, About;

var
 DevicePresent : Boolean;
 Selected_Device_Serial_Number : AnsiString;
 Selected_Device_Description : AnsiString;

{$R *.DFM}

procedure TForm1.FileOpen1Accept(Sender: TObject);
var
  FS: TFileStream;

  version: DWORD;
  libver: DWORD;
  ret: FT_Result;
  i, j, k: integer;
  s: string;

begin
  FS := TFileStream.Create(FileOpen1.Dialog.FileName, fmOpenRead);
  FS.Read(UserData, 256);
  FS.Destroy;

   memo1.Lines.Clear;
   for i := 0 to 16 - 1 do
     begin
       //
       s := '';
       for j := 0 to 16 - 1 do
       begin
         s := s + '$' + inttohex(UserData[i*16+j],2);
         if (j<>15) or (i<>15) then s:= s + ',';
       end;
       memo1.Lines.Add(s);
     end;

   s := '';
   for i := 0 to 256 - 1 do
     if UserData[i] >= 32 then s := s + chr(userdata[i]);

  memo1.Lines.Add(s);
end;

procedure TForm1.FileSaveAs1Accept(Sender: TObject);
var
  FS: TFileStream;
begin
  FS := TFileStream.Create(FileSaveAs1.Dialog.FileName, fmCreate);
  FS.Write(  UserData, 256);
  FS.Destroy;
end;

procedure TForm1.FormShow(Sender: TObject);
var S : AnsiString; I : Integer; DeviceIndex : DWord; LV : TListItem;
begin
Memo1.Clear;
FT_Enable_Error_Report := true; // Error reporting = on
DevicePresent := False;
//Memo1.Enabled := False;
Timer1.Enabled := True;
ListView1.Items.clear;
GetFTDeviceCount;
S := IntToStr(FT_Device_Count);
//Caption := 'D2XX Delphi Demo - '+S+' Device(s) Present ...';
DeviceIndex := 0;

If FT_Device_Count > 0 then
  For I := 1 to FT_Device_Count do
  Begin
  LV := ListView1.Items.Add;
  LV.Caption := 'Device '+IntToStr(I);
  GetFTDeviceSerialNo( DeviceIndex );
  LV.SubItems.Add(FT_Device_String);
  GetFTDeviceDescription ( DeviceIndex );
  LV.SubItems.Add(FT_Device_String);
  DeviceIndex := DeviceIndex + 1;
  End;

    //GetFTDeviceSerialNo( 0 );
end;

procedure TForm1.Timer1Timer(Sender: TObject);
Var PortStatus : FT_Result;  S : AnsiString; DeviceIndex : DWord;  I : Integer;
begin

//Exit; //debug

FT_Enable_Error_Report := False; // Turn off error dialog
If Not DevicePresent then
  Begin
  PortStatus := Close_USB_Device; // In case device was already open
  PortStatus := Open_USB_Device;  // Try and open device
  If PortStatus = FT_OK then      // Device is Now Present !
    Begin
    DevicePresent := True;
    //Caption := 'FTDI Device Present ...';
    StatusBar1.Panels[0].Text := 'Device Present';

//    Memo1.Enabled := True;
    Reset_USB_Device;     // warning - this will destroy any pending data.
    Set_USB_Device_TimeOuts(500,500); // read and write timeouts = 500mS
    End;
  End
else
  Begin
  PortStatus := Get_USB_Device_QueueStatus;
  If PortStatus <> FT_OK then
    Begin   // Device has been Unplugged
    DevicePresent := False;
    //Caption := 'D2XX Delphi Demo - No Device Present ...';
//    Memo1.Enabled := False;
    StatusBar1.Panels[0].Text := 'Error: No Device';
    End else begin
        Purge_USB_Device_Out;
        Purge_USB_Device_In;
    end;
  End;


end;

procedure TForm1.FTSendFileExecute(Sender: TObject);
Var OpenFile : File;  OpenFileName : String;
    FC1,Total,I : Integer;
    S : AnsiString;
begin
end;

procedure TForm1.FTQuitExecute(Sender: TObject);
begin
If DevicePresent then Close_USB_Device;
Close;
end;

procedure TForm1.spi_CS(value: integer);
begin
end;

function TForm1.spi_MISO: integer;
begin
end;

procedure TForm1.spi_MOSI(value: integer);
begin
end;

procedure TForm1.spi_SCL(value: integer);
begin
end;

function TForm1.spi_xfer(value: byte): byte;
begin
end;

procedure TForm1.ee_CS(value: integer);
begin
end;

function TForm1.ee_MISO: integer;
begin
end;

procedure TForm1.ee_MOSI(value: integer);
begin
end;

procedure TForm1.ee_SCL(value: integer);
begin
end;

procedure TForm1.ListView1Click(Sender: TObject);
begin
end;

// lattice

(*
$00,$00,$11,$11,$9A,$10,$AA,$3C,$00,$00,$00,$00,$00,$00,$46,$00,
$10,$03,$4C,$00,$61,$00,$74,$00,$74,$00,$69,$00,$63,$00,$65,$00,
$3C,$03,$4C,$00,$61,$00,$74,$00,$74,$00,$69,$00,$63,$00,$65,$00,
$20,$00,$46,$00,$54,$00,$55,$00,$53,$00,$42,$00,$20,$00,$49,$00,
$6E,$00,$74,$00,$65,$00,$72,$00,$66,$00,$61,$00,$63,$00,$65,$00,
$20,$00,$43,$00,$61,$00,$62,$00,$6C,$00,$65,$00,$00,$00,$00,$00,
$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
*)

(*
// HS1
const
  u_hs1: array[0..255] of byte = (
  $01,$00,$C7,$92,$6A,$35,$50,$01,$70,$30,$4A,$74,$61,$67,$48,$73,
  $31,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$44,$69,$67,$69,$6C,
  $65,$6E,$74,$20,$4A,$54,$41,$47,$2D,$48,$53,$31,$00,$00,$00,$00,
  $00,$00,$00,$00,$00,$00,$00,$00,$11,$00,$00,$00,$00,$00,$00,$00,
  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
  $01,$01,$03,$04,$10,$60,$00,$07,$80,$2F,$08,$00,$00,$00,$9A,$12,
  $AC,$34,$E0,$1A,$00,$00,$00,$00,$56,$00,$01,$00,$C7,$92,$6A,$35,
  $50,$01,$70,$30,$4A,$74,$61,$67,$48,$73,$31,$00,$00,$00,$00,$00,
  $00,$00,$00,$00,$00,$44,$69,$67,$69,$6C,$65,$6E,$74,$20,$4A,$54,
  $41,$47,$2D,$48,$53,$31,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
  $00,$00,$11,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
  $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  );
const
  u_zed: array[0..255] of byte = (

$01,$00,$C7,$92,$6A,$35,$53,$01,$E0,$00,$5A,$65,$64,$00,$00,$00,
$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$44,$69,$67,$69,$6C,
$65,$6E,$74,$20,$5A,$65,$64,$00,$00,$00,$00,$00,$00,$00,$00,$00,
$00,$00,$00,$00,$00,$00,$00,$00,$01,$00,$00,$00,$00,$00,$00,$00,
$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  );

*)


procedure TForm1.Action1Execute(Sender: TObject);
var
  version: DWORD;
  libver: DWORD;
  ret: FT_Result;
  i, j, k: integer;
  s: string;
begin
//  u: array[0..255] of byte = (
//  $01,$00,$C7,$92,$6A,$35,$50,$01,$70,$30,$4A,$74,$61,$67,$48,$73,


   FT_UA_Size := 100;
//   label1.Caption := 'uasize ' + inttostr(FT_UA_Size);
   USB_FT_EE_UASize;
   USB_FT_EE_UARead;

//   label2.Caption := 'uasize ' + inttostr(FT_UA_Size);

   Get_USB_Driver_Version(@version);
   Get_USB_Library_Version(@libver);

   //label2.caption := inttohex(version,8) + ' ' + inttohex(libver,8);
   //
   memo1.Lines.Clear;
   for i := 0 to 16 - 1 do
     begin
       //
       s := '';
       for j := 0 to 16 - 1 do
       begin
         s := s + '$' + inttohex(UserData[i*16+j],2);
         if (j<>15) or (i<>15) then s:= s + ',';

       end;
       memo1.Lines.Add(s);
     end;

   s := '';
   for i := 0 to 256 - 1 do
     if UserData[i] >= 32 then s := s + chr(userdata[i]);

   memo1.Lines.Add(s);

end;

procedure TForm1.Action2Execute(Sender: TObject);
var i: integer;
begin
//  for i := 0 to 256 - 1 do
  //userdata[i] := u_zed[i];
  USB_FT_EE_UAWrite;
end;

procedure TForm1.Action3Execute(Sender: TObject);
begin
  Aboutform.Showmodal;
end;

end.
