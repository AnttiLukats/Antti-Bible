unit jtagex;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,D2XXUNIT, StdCtrls, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Panel2: TPanel;
    ComboBox3: TComboBox;
    Label6: TLabel;
    Button1: TButton;
    Edit2: TEdit;
    Label7: TLabel;
    Button2: TButton;
    Button3: TButton;
    Edit3: TEdit;
    Label8: TLabel;
    Memo1: TMemo;
    Button4: TButton;
    Button5: TButton;
    Panel3: TPanel;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Label4: TLabel;
    Label5: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    Button6: TButton;
    Edit4: TEdit;
    Label12: TLabel;
    Panel4: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    Button7: TButton;
    Edit5: TEdit;
    Button8: TButton;
    Button9: TButton;
    procedure ComboBox1DropDown(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  jtag_state     = (test_logic_reset, run_test_idle, pause_dr, pause_ir,
                     shift_dr, shift_ir, undefined_jtag_state);
  shift_register = (instruction_register,data_register);
  data_type      = array[0..$fffe] of byte;
  data_type_ptr  = ^data_type;
  Names = Array[1..20] of ansistring;
  Names_Ptr = ^Names;


var
  Form1: TForm1;

  My_Names : Names;
  PortAIsOpen : Boolean;
  OutIndex : integer;
  ImageData : ARRAY[0..63] of word;
  CalTime : boolean;
  SavedSpeed : ansistring;
  SavedBits : ansistring;

  UARTIsOpen : Boolean;
  FT_HANDLE_JTAG : DWord = 0;
  FT_HANDLE_UART : DWord = 0;


  //======================================================================
  current_state : jtag_state = undefined_jtag_state;
  data_out,data_in : array[0..60000] of byte;
  SavedLowVal : integer;
  SavedLowDir : integer;
  SavedHighVal : integer;
  SavedHighDir : integer;


  //======================================================================



const USBBuffSize : integer = $8000;

  //======================================================================
  // go to ->                                    tlr rti pdr pir sdr sir
  //======================================================================
  from_test_logic_reset : array[0..5] of byte = ($01,$00,$0a,$16,$02,$06);
  from_run_test_idle : array[0..5] of byte    = ($07,$00,$05,$0b,$01,$03);
  from_pause_dr : array[0..5] of byte         = ($1f,$03,$17,$2f,$01,$0f);
  from_pause_ir : array[0..5] of byte         = ($1f,$03,$17,$2f,$07,$01);
  from_shift_dr : array[0..5] of byte         = ($1f,$03,$01,$2f,$00,$00);
  from_shift_ir : array[0..5] of byte         = ($1f,$03,$17,$01,$00,$00);
  //======================================================================
  // with this number of clocks
  //======================================================================
  from_test_logic_resetc : array[0..5] of byte = (1,1,5,6,4,5);
  from_run_test_idlec : array[0..5] of byte    = (3,5,4,5,3,4);
  from_pause_drc : array[0..5] of byte         = (5,3,6,7,2,6);
  from_pause_irc : array[0..5] of byte         = (5,3,6,7,5,2);
  from_shift_drc : array[0..5] of byte         = (5,3,2,7,0,0);
  from_shift_irc : array[0..5] of byte         = (5,4,6,2,0,0);

  ir_bdry_scan  = $00;
  ir_samp_scan  = $82;
  ir_bypass     = $04;

  //======================================================================


implementation

{$R *.dfm}


function timeout_ms(start_time, end_time: TDateTime; timeout_val: integer): boolean;
var
  start_hour, start_min, start_sec, start_ms: word;
  end_hour,   end_min,   end_sec,   end_ms  : word;
begin
  decodetime(start_time, start_hour, start_min, start_sec, start_ms);
  decodetime(end_time,   end_hour,   end_min,   end_sec,   end_ms);
  end_min := end_min + (60 * (end_hour - start_hour));
  end_sec := end_sec + (60 * (end_min - start_min));
  end_ms  := end_ms  + (1000 * (end_sec - start_sec));
  timeout_ms := (end_ms - start_ms) >= timeout_val;
end;

procedure DispMsg(ts : ansistring);
begin
form1.Memo1.Lines.Append(ts);
end;

function OpenPort(PortName : ansistring) : boolean;
Var res : FT_Result;
NoOfDevs,i,J : integer;
Name : ansiString;
DualName : ansistring;
done : boolean;
begin
PortAIsOpen := False;
OpenPort := False;
Name := '';
Dualname := PortName;
res := GetFTDeviceCount;

if res <> Ft_OK then exit;
NoOfDevs := FT_Device_Count;
j := 0;
if NoOfDevs > 0 then
  begin
    repeat
      repeat
      res := GetFTDeviceDescription(J);
      if (res <> Ft_OK) then  J := J + 1;
      until (res = Ft_OK) OR (J=NoOfDevs);
    if res <> Ft_OK then exit;
    done := false;
    i := 1;
    Name := '';
    (*
      repeat
      if ORD(FT_Device_String_Buffer[i]) <> 0 then
        begin
        Name := Name + FT_Device_String_Buffer[i];
        end
      else
        begin
        done := true;
        end;
      i := i + 1;
      until done;
      *)
      Name := FT_Device_String;

    J := J + 1;
    until (J = NoOfDevs) or (name = DualName);
  end;

if (name = DualName) then
  begin
  res := Open_USB_Device_By_Device_Description(name);
  if res <> Ft_OK then exit;
  OpenPort := true;
  res := Get_USB_Device_QueueStatus;
  if res <> Ft_OK then exit;
  PortAIsOpen := true;
  end
else
  begin
  OpenPort := false;
  end;


end;


procedure List_Devs( My_Names_Ptr : Names_Ptr);
Var res : FT_Result;
NoOfDevs,i,J,k : integer;
Name : ansiString;
done : boolean;
begin
PortAIsOpen := False;
Name := '';
res := GetFTDeviceCount;
if res <> Ft_OK then exit;
NoOfDevs := FT_Device_Count;
j := 0;
k := 1;
if NoOfDevs > 0 then
  begin
    repeat
    res := GetFTDeviceDescription(J);
    if res = Ft_OK then
      begin
      done := false;
      i := 1;
      Name := FT_Device_String;
      (*
        repeat
        if ORD(FT_Device_String_Buffer[i]) <> 0 then
          begin
          Name := Name + FT_Device_String_Buffer[i];
          end
        else
          begin
            done := true;
            My_Names_Ptr[k]:= Name;
            k := k + 1;
          end;
        i := i + 1;
        until done;
        *)
            My_Names_Ptr[k]:= Name;
            k := k + 1;

      end;
    J := J + 1;
    until (J = NoOfDevs);
  end;end;


procedure ClosePort;
Var res : FT_Result;
begin
if PortAIsOpen then
  res := Close_USB_Device;
PortAIsOpen := False;
end;


procedure SendBytes(NumberOfBytes : integer);
var i : integer;
begin
i := Write_USB_Device_Buffer( NumberOfBytes);
OutIndex := OutIndex - i;
end;


procedure AddToBuffer(I:integer);
begin
FT_Out_Buffer[OutIndex]:= I AND $FF;
inc(OutIndex);
end;


function Check_For_Dev_A(Name : string) : boolean;
var len : integer;
SubString : ansistring;
begin
Check_For_Dev_A := false;
if (Name <> '') then
  begin
  len := length(Name);
  if (len > 2) then
    begin
    SubString := Name[len-1] + Name[len];
    if (SubString = ' A') then Check_For_Dev_A := true;
    if (SubString = ' B') then Check_For_Dev_A := true;

    end;
  end;
end;

procedure GetNames;
Var i : integer;
Has_A : boolean;
begin
for i := 1 to 20 do My_Names[i] := '';
Form1.ComboBox1.Clear;
List_Devs(@My_Names);
i := 1;
if (My_Names[i] <> '' ) then
  begin
    repeat
    Has_A := Check_For_Dev_A(My_Names[i]);
    if Has_A then Form1.ComboBox1.Items.Add(My_Names[i]);
    i := i + 1;
    until (My_Names[i] = '');
  end;
end;



//=========================================================
//== application things after here
//=========================================================

function HexWrdToStr(Dval : integer) : ansistring;
var i : integer;
retstr : ansistring;
begin
retstr := '';
i := (Dval AND $F000) DIV $1000;
case i of
  0 : retstr := retstr + '0';
  1 : retstr := retstr + '1';
  2 : retstr := retstr + '2';
  3 : retstr := retstr + '3';
  4 : retstr := retstr + '4';
  5 : retstr := retstr + '5';
  6 : retstr := retstr + '6';
  7 : retstr := retstr + '7';
  8 : retstr := retstr + '8';
  9 : retstr := retstr + '9';
  10 : retstr := retstr + 'A';
  11 : retstr := retstr + 'B';
  12 : retstr := retstr + 'C';
  13 : retstr := retstr + 'D';
  14 : retstr := retstr + 'E';
  15 : retstr := retstr + 'F';
end;
i := (Dval AND $F00) DIV $100;
case i of
  0 : retstr := retstr + '0';
  1 : retstr := retstr + '1';
  2 : retstr := retstr + '2';
  3 : retstr := retstr + '3';
  4 : retstr := retstr + '4';
  5 : retstr := retstr + '5';
  6 : retstr := retstr + '6';
  7 : retstr := retstr + '7';
  8 : retstr := retstr + '8';
  9 : retstr := retstr + '9';
  10 : retstr := retstr + 'A';
  11 : retstr := retstr + 'B';
  12 : retstr := retstr + 'C';
  13 : retstr := retstr + 'D';
  14 : retstr := retstr + 'E';
  15 : retstr := retstr + 'F';
end;
i := (Dval AND $F0) DIV $10;
case i of
  0 : retstr := retstr + '0';
  1 : retstr := retstr + '1';
  2 : retstr := retstr + '2';
  3 : retstr := retstr + '3';
  4 : retstr := retstr + '4';
  5 : retstr := retstr + '5';
  6 : retstr := retstr + '6';
  7 : retstr := retstr + '7';
  8 : retstr := retstr + '8';
  9 : retstr := retstr + '9';
  10 : retstr := retstr + 'A';
  11 : retstr := retstr + 'B';
  12 : retstr := retstr + 'C';
  13 : retstr := retstr + 'D';
  14 : retstr := retstr + 'E';
  15 : retstr := retstr + 'F';
end;
i := Dval AND $F;
case i of
  0 : retstr := retstr + '0';
  1 : retstr := retstr + '1';
  2 : retstr := retstr + '2';
  3 : retstr := retstr + '3';
  4 : retstr := retstr + '4';
  5 : retstr := retstr + '5';
  6 : retstr := retstr + '6';
  7 : retstr := retstr + '7';
  8 : retstr := retstr + '8';
  9 : retstr := retstr + '9';
  10 : retstr := retstr + 'A';
  11 : retstr := retstr + 'B';
  12 : retstr := retstr + 'C';
  13 : retstr := retstr + 'D';
  14 : retstr := retstr + 'E';
  15 : retstr := retstr + 'F';
end;
HexWrdToStr := retstr;
end;

function HexByteToStr(Dval : integer) : ansistring;
var i : integer;
retstr : ansistring;
begin
retstr := '';
i := (Dval AND $F0) DIV $10;
case i of
  0 : retstr := retstr + '0';
  1 : retstr := retstr + '1';
  2 : retstr := retstr + '2';
  3 : retstr := retstr + '3';
  4 : retstr := retstr + '4';
  5 : retstr := retstr + '5';
  6 : retstr := retstr + '6';
  7 : retstr := retstr + '7';
  8 : retstr := retstr + '8';
  9 : retstr := retstr + '9';
  10 : retstr := retstr + 'A';
  11 : retstr := retstr + 'B';
  12 : retstr := retstr + 'C';
  13 : retstr := retstr + 'D';
  14 : retstr := retstr + 'E';
  15 : retstr := retstr + 'F';
end;
i := Dval AND $F;
case i of
  0 : retstr := retstr + '0';
  1 : retstr := retstr + '1';
  2 : retstr := retstr + '2';
  3 : retstr := retstr + '3';
  4 : retstr := retstr + '4';
  5 : retstr := retstr + '5';
  6 : retstr := retstr + '6';
  7 : retstr := retstr + '7';
  8 : retstr := retstr + '8';
  9 : retstr := retstr + '9';
  10 : retstr := retstr + 'A';
  11 : retstr := retstr + 'B';
  12 : retstr := retstr + 'C';
  13 : retstr := retstr + 'D';
  14 : retstr := retstr + 'E';
  15 : retstr := retstr + 'F';
end;
HexByteToStr := retstr;
end;


function HexNibToStr(Dval : integer) : ansistring;
var i : integer;
retstr : ansistring;
begin
retstr := '';
i := Dval AND $F;
case i of
  0 : retstr := retstr + '0';
  1 : retstr := retstr + '1';
  2 : retstr := retstr + '2';
  3 : retstr := retstr + '3';
  4 : retstr := retstr + '4';
  5 : retstr := retstr + '5';
  6 : retstr := retstr + '6';
  7 : retstr := retstr + '7';
  8 : retstr := retstr + '8';
  9 : retstr := retstr + '9';
  10 : retstr := retstr + 'A';
  11 : retstr := retstr + 'B';
  12 : retstr := retstr + 'C';
  13 : retstr := retstr + 'D';
  14 : retstr := retstr + 'E';
  15 : retstr := retstr + 'F';
end;
HexNibToStr := retstr;
end;




//======================================================================
// add to memo box
//======================================================================

procedure showdata(rcvddata : integer);
var CharH,CharL : Char;
i : integer;
begin
i := (RcvdData AND $FF00) DIV 256;
if (i > $2F) AND (i <$7F) then
  begin
  CharH := chr(i);
  end
else
  begin
  CharH := '.';
  end;
i := RcvdData AND $FF;
if (i > $2F) AND (i <$7F) then
  begin
  CharL := chr(i);
  end
else
  begin
  CharL := '.';
  end;

form1.Memo1.Lines.Append(HexWrdtostr(RcvdData)+' '+CharH+CharL);
end;

//======================================================================
// purge data buffer
//======================================================================
procedure PurgeChip;
var res : FT_Result;
 j : integer;
begin
res := Reset_USB_Device;
// check for old data
res := Get_USB_Device_QueueStatus;
if FT_Q_Bytes > 0 then
  j := Read_USB_Device_Buffer(FT_Q_Bytes);
end;


procedure waitDelay;
begin
end;

procedure SndImmediate;
begin
OutIndex := 0;
AddToBuffer($87); // Send Immediate
SendBytes(OutIndex); // send off the command
end;


procedure LoopBackOn;
begin
OutIndex := 0;
AddToBuffer($84);
SendBytes(OutIndex); // send off the command
end;

procedure LoopBackOff;
begin
OutIndex := 0;
AddToBuffer($85);
SendBytes(OutIndex); // send off the command
end;

//======================================================================
//== JTAG state transition code
//======================================================================

procedure wiggler_do_tms(tmsval,count : byte;Do_Read : boolean);
begin
if count = 0 then exit;
if count > 7 then exit;
if Do_Read then AddToBuffer($6B) else AddToBuffer($4B);
AddToBuffer(count-1);
AddToBuffer(tmsval);
end;

function wiggler_move_state(new_state : jtag_state;last_data : byte;Do_Read : boolean) : integer;
//
// this returns the number of TMS clocks to work out the last bit of TDO
//
begin
if current_state = undefined_jtag_state then
  begin
  wiggler_do_tms($7F,7,false);
  current_state := test_logic_reset;
  end;

wiggler_move_state := 0;

case current_state of
  test_logic_reset:
    begin
    wiggler_do_tms(from_test_logic_reset[byte(new_state)] or (last_data SHL 7),
      from_test_logic_resetc[byte(new_state)],Do_Read);
    wiggler_move_state := from_test_logic_resetc[byte(new_state)];
    end;
  run_test_idle:
    begin
    wiggler_do_tms(from_run_test_idle[byte(new_state)] or (last_data SHL 7),
      from_run_test_idlec[byte(new_state)],Do_Read);
    wiggler_move_state := from_run_test_idlec[byte(new_state)];
    end;
  pause_dr:
    begin
    wiggler_do_tms(from_pause_dr[byte(new_state)] or (last_data SHL 7),
      from_pause_drc[byte(new_state)],Do_Read);
    wiggler_move_state := from_pause_drc[byte(new_state)];
    end;
  pause_ir:
    begin
    wiggler_do_tms(from_pause_ir[byte(new_state)] or (last_data SHL 7),
      from_pause_irc[byte(new_state)],Do_Read);
    wiggler_move_state := from_pause_irc[byte(new_state)];
    end;
  shift_dr:
    begin
    wiggler_do_tms(from_shift_dr[byte(new_state)] or (last_data SHL 7),
      from_shift_drc[byte(new_state)],Do_Read);
    wiggler_move_state := from_shift_drc[byte(new_state)];
    end;
  shift_ir:
    begin
    wiggler_do_tms(from_shift_ir[byte(new_state)] or (last_data SHL 7),
      from_shift_irc[byte(new_state)],Do_Read);
    wiggler_move_state := from_shift_irc[byte(new_state)];
    end;
  end;
current_state := new_state;
end;

//======================================================================
//== End Of JTAG state transition code
//======================================================================

//=======================================================
// Routines to Control MPSSE hardware
//=======================================================

function Get_Data(in_data : data_type_ptr;Bit_Length : word;
                   TMS_Clks : integer) : boolean;
//
// This will work out the number of whole bytes to read and adjust
// for the TMS read
//
var res : FT_Result;
NoBytes,i,j : integer;
BitShift,Mod_Bit_Length : integer;
Last_Bit : byte;
Temp_Buffer : array[0..64000] of byte;
TotalBytes : integer;
timeout_start: TDateTime;
timeout_end  : TDateTime;
timeout     : boolean;
begin
Get_Data := false;
i := 0;
Mod_Bit_Length := Bit_Length - 1; // adjust for bit count of 1 less than no of bits
NoBytes := Mod_Bit_Length DIV 8;  // get whole bytes
BitShift := Mod_Bit_Length MOD 8; // get remaining bits
if BitShift > 0 then NoBytes := NoBytes + 1; // bump whole bytes if bits left over
BitShift := 8 - BitShift; // adjust for SHR of incoming byte
NoBytes := NoBytes + 1; // add 1 for TMS read byte
i := 0;
TotalBytes := 0;
repeat
  timeout_start := now;
  repeat
    res := Get_USB_Device_QueueStatus;
    if ( FT_Q_Bytes = 0) then sleep(0); // give up timeslice
    timeout_end := now;
    timeout := timeout_ms(timeout_start, timeout_end, 5000);
  until (FT_Q_Bytes > 0) or (res <> FT_OK) or timeout;
  if (FT_Q_Bytes > 0) then
    begin
    j := Read_USB_Device_Buffer(FT_Q_Bytes);
    for i := 0 to (j-1) do
      begin
      Temp_Buffer[TotalBytes] := FT_In_Buffer[i];
      TotalBytes := TotalBytes + 1;
      end;
    end;
until (TotalBytes >= NoBytes) or (res <> FT_OK) or timeout;

if not(timeout) and (res = FT_OK) then
  begin
  Get_Data := true;
  //adjust last 2 bytes
  if (BitShift < 8 ) THEN
    begin
    Temp_Buffer[NoBytes-2] := Temp_Buffer[NoBytes-2] SHR BitShift;
    Last_Bit := Temp_Buffer[NoBytes-1] SHL (TMS_Clks-1);
    Last_Bit := Last_Bit AND $80; // strip the rest
    Temp_Buffer[NoBytes-2] := Temp_Buffer[NoBytes-2] OR (Last_Bit SHR (BitShift-1));
    for j := 0 to (NoBytes-2) do
      begin
      in_data[j] := Temp_Buffer[j];
      end;
    end
  else // case for 0 bit shift in data + TMS read bit
    begin
    Last_Bit := Temp_Buffer[NoBytes-1] SHL (TMS_Clks-1);
    Last_Bit := Last_Bit SHR 7; // strip the rest
    Temp_Buffer[NoBytes-1] := Last_Bit;
    for j := 0 to (NoBytes-1) do
      begin
      in_data[j] := Temp_Buffer[j];
      end;
    end;
  end;
end;

procedure s_out(jtag_register : shift_register; bit_length : word;
                   out_data : data_type_ptr; state : jtag_state);
//
// JTAG Scan out
//
var i,j,TMS_Clks : integer;
LastBit : byte;
Mod_bit_length : word;
Do_Read : boolean;
begin
if PortAIsOpen then
  begin
  OutIndex := 0;
  j := 0;
  Mod_bit_length := bit_length - 1;
  Do_Read := false;
  if (jtag_register = instruction_register) then
    TMS_Clks := wiggler_move_state(shift_ir,0,Do_Read)
  else
    TMS_Clks := wiggler_move_state(shift_dr,0,Do_Read);

  if Mod_bit_length div 8 > 0 then
    begin // do whole bytes
    i := (Mod_bit_length div 8) - 1;
    AddToBuffer($19); // clk data bytes out on -ve clk LSB
    AddToBuffer(i AND $FF);
    AddToBuffer((i DIV 256) AND $FF);
    // now add the data bytes to go out
      repeat
      AddToBuffer(out_data[j]);
      j := j + 1;
      until j > i;
    end;
  if Mod_bit_length mod 8 > 0 then
    begin // do remaining bits
    i := (Mod_bit_length mod 8) - 1;
    AddToBuffer($1B); // clk data bits out on -ve clk LSB
    AddToBuffer(i AND $FF);
    // now add the data bits to go out
    AddToBuffer(out_data[j]);
    end;
  // get LastBit
  LastBit := out_data[j];
  j := bit_length mod 8;
  LastBit := LastBit SHR (8-j-1);
  TMS_Clks := wiggler_move_state(state,LastBit,Do_Read); // end it in state passed in
  SendBytes(OutIndex); // send off the command
  end;
end;

procedure s_io(jtag_register : shift_register;
                  bit_length : word; out_data, in_data : data_type_ptr;
                  state : jtag_state;SendImmediate : boolean );
//
// JTAG Scan in and out
//
var i,j,TMS_Clks : integer;
LastBit : byte;
Mod_bit_length : word;
Do_Read,passed : boolean;

begin
if PortAIsOpen then
  begin
  OutIndex := 0;
  j := 0;
  Mod_bit_length := bit_length - 1;
  Do_Read := false;
  if (jtag_register = instruction_register) then
    TMS_Clks := wiggler_move_state(shift_ir,0,Do_Read)
  else
    TMS_Clks := wiggler_move_state(shift_dr,0,Do_Read);

  if Mod_bit_length div 8 > 0 then
    begin // do whole bytes
    i := (Mod_bit_length div 8) - 1;
    AddToBuffer($39); // clk data bytes out on -ve in +ve clk LSB
    AddToBuffer(i AND $FF);
    AddToBuffer((i DIV 256) AND $FF);
    // now add the data bytes to go out
      repeat
      AddToBuffer(out_data[j]);
      j := j + 1;
      until j > i;
    end;
  if Mod_bit_length mod 8 > 0 then
    begin // do remaining bits
    i := (Mod_bit_length mod 8) - 1;
    AddToBuffer($3B); // clk data bits out on -ve in +ve clk LSB
    AddToBuffer(i AND $FF);
    // now add the data bits to go out
    AddToBuffer(out_data[j]);
    end;
  // get LastBit
  LastBit := out_data[j];
  j := bit_length mod 8;
  LastBit := LastBit SHR (8-j-1);
  Do_Read := true;
  TMS_Clks := wiggler_move_state(state,LastBit,Do_Read); // end it in state passed in
  if SendImmediate then AddToBuffer($87);
  SendBytes(OutIndex); // send off the command
  // now wait for data
  passed := Get_Data(in_data,Bit_Length,TMS_Clks);
  //
  end;
end;

procedure s_in(jtag_register : shift_register; bit_length : word;
                   in_data : data_type_ptr; state : jtag_state;
                   TDILevel : byte;SendImmediate : boolean);
//
// JTAG Scan in
//
var i,TMS_Clks : integer;
Mod_bit_length : word;
Do_Read : boolean;
Passed : boolean;

begin
if PortAIsOpen then
  begin
  OutIndex := 0;
  Mod_bit_length := bit_length - 1;
  Do_Read := false;
  if (jtag_register = instruction_register) then
    TMS_Clks := wiggler_move_state(shift_ir,TDILevel,Do_Read)
  else
    TMS_Clks := wiggler_move_state(shift_dr,TDILevel,Do_Read);

  if Mod_bit_length div 8 > 0 then
    begin // do whole bytes
    i := (Mod_bit_length div 8) - 1;
    AddToBuffer($28); // clk data bytes in LSB +ve clk
    AddToBuffer(i AND $FF);
    AddToBuffer((i DIV 256) AND $FF);
    end;
  if Mod_bit_length mod 8 > 0 then
    begin // do remaining bits
    i := (Mod_bit_length mod 8) - 1;
    AddToBuffer($2A); // clk data bits in LSB +ve clk
    AddToBuffer(i AND $FF);
    end;
  Do_Read := true;
  TMS_Clks := wiggler_move_state(state,TDILevel,Do_Read); // end it in state passed in
  if SendImmediate then AddToBuffer($87);
  SendBytes(OutIndex); // send off the command
  // now wait for data
  passed := Get_Data(in_data,Bit_Length,TMS_Clks);
  end;
end;

procedure W_LowPins(Valpin,DirPin : byte);
var i : byte;
begin
if PortAIsOpen then
  begin
  OutIndex := 0;
  AddToBuffer($80); // output  on GPIO L1-4
  SavedLowVal := SavedLowVal AND $F;
  SavedLowDir := SavedLowDir AND $F;
  i := ValPin AND $F;
  SavedLowVal := SavedLowVal or (i * $10);
  i := DirPin AND $F;
  SavedLowDir := SavedLowDir or (i * $10);
  AddToBuffer(SavedLowVal);
  AddToBuffer(SavedLowDir); // direction
  SendBytes(OutIndex); // send off the command
  end;
end;


procedure W_HighPins(Valpin,DirPin : byte);
var i : byte;
begin
if PortAIsOpen then
  begin
  OutIndex := 0;
  AddToBuffer($82); // output  on GPIO H1-4
  i := ValPin;
  AddToBuffer(i);
  i := DirPin;
  AddToBuffer(i); // direction
  SendBytes(OutIndex); // send off the command
  end;
end;

function R_LowInputs : byte;
var res : FT_Result;
i,j : integer;
timeout_start: TDateTime;
timeout_end  : TDateTime;
timeout     : boolean;
begin
R_LowInputs := $00;
if PortAIsOpen then
  begin
  OutIndex := 0;
  AddToBuffer($81); // inputs on GPIOL 1-4
  AddToBuffer($87); // send immediate
  SendBytes(OutIndex); // send off the command
  // now wait for data
  timeout_start := now;
  repeat
    res := Get_USB_Device_QueueStatus;
    if ( FT_Q_Bytes = 0) then sleep(0); // give up timeslice
    timeout_end := now;
    timeout := timeout_ms(timeout_start, timeout_end, 5000);
  until (FT_Q_Bytes >= 1) or (res <> FT_OK) or timeout;

  IF (FT_Q_Bytes > 0) then
    begin
    i := Read_USB_Device_Buffer(FT_Q_Bytes);
    i := FT_In_Buffer[0] SHR 4;
    R_LowInputs := i AND $0F;
    end;
  end;
end;


function R_HighInputs : byte;
var res : FT_Result;
i,j : integer;
timeout_start: TDateTime;
timeout_end  : TDateTime;
timeout     : boolean;
begin
R_HighInputs := $00;
if PortAIsOpen then
  begin
  OutIndex := 0;
  AddToBuffer($83); // inputs on GPIOH 1-4
  AddToBuffer($87); // send immediate
  SendBytes(OutIndex); // send off the command
  // now wait for data
  timeout_start := now;
  repeat
    res := Get_USB_Device_QueueStatus;
    if ( FT_Q_Bytes = 0) then sleep(0); // give up timeslice
    timeout_end := now;
    timeout := timeout_ms(timeout_start, timeout_end, 5000);
  until (FT_Q_Bytes >= 1) or (res <> FT_OK) or timeout;

  IF (FT_Q_Bytes > 0) then
    begin
    i := Read_USB_Device_Buffer(FT_Q_Bytes);
    i := FT_In_Buffer[0];
    R_HighInputs := i AND $0F;
    end;
  end;
end;

function InSync : boolean;
var res : FT_Result;
j : integer;
begin
InSync := false;
OutIndex := 0;
AddToBuffer($bb);
SendBytes(OutIndex); // send off the command
  repeat
    res := Get_USB_Device_QueueStatus;
  until FT_Q_Bytes > 0;
  j := Read_USB_Device_Buffer(FT_Q_Bytes);
end;

function Init_Controller(speed : word) : boolean;
var passed : boolean;
res : FT_Result;
DeviceName : ansiString;
begin
Init_Controller := false;
form1.Memo1.Clear;
form1.Memo1.Update;
DeviceName := Form1.ComboBox1.Text;
passed := false;
if (DeviceName <> '') then
  begin
  passed := OpenPort(DeviceName);
  end
else
  begin
  DispMsg('no valid device selected in drop down window');
  end;
if Passed then
  begin
  PurgeChip;

  res := Set_USB_Device_LatencyTimer(16);
  res := Set_USB_Device_BitMode($00,$00); // reset controller
  res := Set_USB_Device_BitMode($00,$02); // enable JTAG controller

  PurgeChip;
  OutIndex := 0;

  sleep(20); // wait for all the USB stuff to complete

  AddToBuffer($80); // set I/O low bits all out except TDO
  SavedLowVal := SavedLowVal AND $F0;
  SavedLowVal := SavedLowVal OR $08; // TDI,TCK start low
  AddToBuffer(SavedLowVal);
  SavedLowDir := SavedLowDir AND $F0;
  SavedLowDir := SavedLowDir OR $0B;
  AddToBuffer(SavedLowDir);
  AddToBuffer($82); // output on GPIOH 1-4
  AddToBuffer(SavedHighVal);
  AddToBuffer(SavedHighDir);
  AddToBuffer($86); // set clk divisor
  AddToBuffer(speed AND $FF);
  AddToBuffer(speed SHR 8);
  // turn off loop back
  AddToBuffer($85);

  SendBytes(OutIndex); // send off the command
  Init_Controller := passed;
  end;
end;

procedure Rst_tap(state : jtag_state);
var Do_Read : boolean;
TMS_Clks : integer;
begin
if PortAIsOpen then
  begin
  sleep(20); // wait for all the USB stuff to complete
  PurgeChip;
  sleep(20); // wait for all the USB stuff to complete
  OutIndex := 0;
  AddToBuffer($80); // set I/O low bits all out except TDO
  SavedLowVal := SavedLowVal AND $F0;
  SavedLowVal := SavedLowVal OR $08; // TDI,TCK start low
  AddToBuffer(SavedLowVal);
  SavedLowDir := SavedLowDir AND $F0;
  SavedLowDir := SavedLowDir OR $0B;
  AddToBuffer(SavedLowDir);
  current_state := undefined_jtag_state;
  Do_Read := false;
  TMS_Clks := wiggler_move_state(test_logic_reset,1,Do_Read);
  TMS_Clks := wiggler_move_state(state,0,Do_Read);
  SendBytes(OutIndex); // send off the command
  PurgeChip;
  end;
end;

//=======================================================
// End - Routines to Control MPSSE hardware
//=======================================================

procedure TForm1.ComboBox1DropDown(Sender: TObject);
begin
GetNames;
end;

function NibbleToHex(charStr : ansistring) : byte;
var tmpint : byte;
begin
tmpint := 0;
if CharStr = '0' then tmpint := 0;
if CharStr =  '1' then tmpint := 1;
if CharStr =  '2' then tmpint := 2;
if CharStr =  '3' then tmpint := 3;
if CharStr =  '4' then tmpint := 4;
if CharStr =  '5' then tmpint := 5;
if CharStr =  '6' then tmpint := 6;
if CharStr =  '7' then tmpint := 7;
if CharStr =  '8' then tmpint := 8;
if CharStr =  '9' then tmpint := 9;
if CharStr =  'A' then tmpint := 10;
if CharStr =  'B' then tmpint := 11;
if CharStr =  'C' then tmpint := 12;
if CharStr =  'D' then tmpint := 13;
if CharStr =  'E' then tmpint := 14;
if CharStr =  'F' then tmpint := 15;
if CharStr =  'a' then tmpint := 10;
if CharStr =  'b' then tmpint := 11;
if CharStr =  'c' then tmpint := 12;
if CharStr =  'd' then tmpint := 13;
if CharStr =  'e' then tmpint := 14;
if CharStr =  'f' then tmpint := 15;
NibbleToHex := tmpint;

end;

function StrToHex(c4harStr : ansiString) : integer;
var tmpint,I,J : integer;
nibbleStr : ansiString;
begin
tmpint := 0;
I := Length(c4harStr);
J := 0;
repeat
  nibbleStr := C4harStr[J+1];
  if (nibbleStr <> ' ') then
    begin
    tmpint := (tmpint*16) + NibbleToHex(nibbleStr);
    end;
  J := J + 1;
until J = I;
StrToHex := tmpint;
end;


procedure ProcessForm(var jtag_register : shift_register;
                      var bit_length : word;
                      var state : jtag_state;
                      var TDILevel : byte);
var i : integer;
begin
if (form1.ComboBox3.ItemIndex = 1) then
  jtag_register := instruction_register
else
  jtag_register := data_register;

bit_length := strtoint(form1.Edit3.Text);

state := run_test_idle;

TDILevel := 0;

//parse   data
i := StrToHex(form1.Edit2.Text);
data_out[0] := i AND $FF;
data_out[1] := (i AND $FF00) div $100;
data_out[2] := (i AND $FF0000) div $10000;
data_out[3] := (i AND $FF000000) div $1000000;

end;



Procedure ScanIn;
var jtag_register : shift_register;
bit_length : word;
state : jtag_state;
TDILevel : byte;
SendImmediate : boolean;

begin
if PortAIsOpen then
  begin
  DispMsg('Doing a Scan In');
  ProcessForm(jtag_register,bit_length,state,TDILevel);
  SendImmediate := true;
  s_in(jtag_register,bit_length,@data_in[0],state,TDILevel,SendImmediate);

  DispMsg('Read back : '+ HexByteToStr(data_in[3]) +' '+
                          HexByteToStr(data_in[2]) +' '+
                          HexByteToStr(data_in[1]) +' '+
                          HexByteToStr(data_in[0]));

  end
else
  begin
  DispMsg('Device is not open');
  end;
end;

Procedure ScanInOut;
var jtag_register : shift_register;
bit_length : word;
state : jtag_state;
TDILevel : byte;
SendImmediate : boolean;

begin
if PortAIsOpen then
  begin
  DispMsg('Doing a Scan In and Out');
  ProcessForm(jtag_register,bit_length,state,TDILevel);
  SendImmediate := true;
  s_io(jtag_register,bit_length,@data_out[0],@data_in[0],state,SendImmediate);

  DispMsg('Read back : '+ HexByteToStr(data_in[3]) +' '+
                          HexByteToStr(data_in[2]) +' '+
                          HexByteToStr(data_in[1]) +' '+
                          HexByteToStr(data_in[0]));

  end
else
  begin
  DispMsg('Device is not open');
  end;
end;


Procedure ScanOut;
var jtag_register : shift_register;
bit_length : word;
state : jtag_state;
TDILevel : byte;

begin
if PortAIsOpen then
  begin
  DispMsg('Doing a Scan Out');
  ProcessForm(jtag_register,bit_length,state,TDILevel);
  s_out(jtag_register,bit_length,@data_out[0],state);

  end
else
  begin
  DispMsg('Device is not open');
  end;
end;


procedure TForm1.Edit1Change(Sender: TObject);
var i : integer;
begin
try
i := strtoint(form1.edit1.Text);
except
form1.Edit1.Text := savedspeed;
end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
savedspeed := '0';
SavedBits :='32';
SavedLowVal := 0;
SavedLowDir := 0;
SavedHighVal := 0;
SavedHighDir := 0;
end;

procedure TForm1.Edit3Change(Sender: TObject);
var i : integer;
begin
try
i := strtoint(form1.edit3.Text);
except
form1.Edit3.Text := savedbits;
end;
end;

procedure OpenDevice;
var speed : word;
passed : boolean;
begin
SavedSpeed := form1.Edit1.Text;
Form1.Memo1.Clear;
DispMsg('Opening device');
speed := strtoint(form1.Edit1.Text);
passed := Init_Controller(speed);
if passed then
  begin
  DispMsg('Open success');
  DispMsg('Resetting TAP controller');
  Rst_tap(run_test_idle); // reset TAP controller and put it in
                          // run test idle
  end
else
  begin
  DispMsg('Open failed');
  end;
end;

procedure UpdateLowIO;
var ValPin,DirPin : byte;
begin
if PortAIsOpen then
  begin
  DispMsg('Writing value to GPIOL 1-4');
  ValPin := 0;
  DirPin := 0;
  if form1.CheckBox5.Checked then ValPin := ValPin or $01;
  if form1.CheckBox6.Checked then ValPin := ValPin or $02;
  if form1.CheckBox7.Checked then ValPin := ValPin or $04;
  if form1.CheckBox8.Checked then ValPin := ValPin or $08;
  if form1.CheckBox1.Checked then DirPin := DirPin or $01;
  if form1.CheckBox2.Checked then DirPin := DirPin or $02;
  if form1.CheckBox3.Checked then DirPin := DirPin or $04;
  if form1.CheckBox4.Checked then DirPin := DirPin or $08;
  W_LowPins(Valpin,DirPin);
  DispMsg('Reading value from GPIOL 1-4');
  ValPin := R_LowInputs;
  form1.Edit4.Text := HexNibToStr(ValPin);
  end
else
  begin
  DispMsg('Device is not open');
  end;
end;


procedure UpdateHighIO;
var ValPin,DirPin : byte;
begin
if PortAIsOpen then
  begin
  DispMsg('Writing value to GPIOH 1-4');
  ValPin := 0;
  DirPin := 0;
  if form1.CheckBox13.Checked then ValPin := ValPin or $01;
  if form1.CheckBox14.Checked then ValPin := ValPin or $02;
  if form1.CheckBox15.Checked then ValPin := ValPin or $04;
  if form1.CheckBox16.Checked then ValPin := ValPin or $08;
  if form1.CheckBox9.Checked then DirPin := DirPin or $01;
  if form1.CheckBox10.Checked then DirPin := DirPin or $02;
  if form1.CheckBox11.Checked then DirPin := DirPin or $04;
  if form1.CheckBox12.Checked then DirPin := DirPin or $08;
  W_HighPins(Valpin,DirPin);
  DispMsg('Reading value from GPIOH 1-4');
  ValPin := R_HighInputs;
  form1.Edit5.Text := HexNibToStr(ValPin);
  end
else
  begin
  DispMsg('Device is not open');
  end;
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
form1.Button1.Enabled := false;
form1.Button2.Enabled := false;
form1.Button3.Enabled := false;
form1.Button4.Enabled := false;
form1.Button5.Enabled := false;
form1.Button6.Enabled := false;
form1.Button7.Enabled := false;
ScanIn;
form1.Button1.Enabled := true;
form1.Button2.Enabled := true;
form1.Button3.Enabled := true;
form1.Button4.Enabled := true;
form1.Button5.Enabled := true;
form1.Button6.Enabled := true;
form1.Button7.Enabled := true;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
form1.Button1.Enabled := false;
form1.Button2.Enabled := false;
form1.Button3.Enabled := false;
form1.Button4.Enabled := false;
form1.Button5.Enabled := false;
form1.Button6.Enabled := false;
form1.Button7.Enabled := false;
ScanOut;
form1.Button1.Enabled := true;
form1.Button2.Enabled := true;
form1.Button3.Enabled := true;
form1.Button4.Enabled := true;
form1.Button5.Enabled := true;
form1.Button6.Enabled := true;
form1.Button7.Enabled := true;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
form1.Button1.Enabled := false;
form1.Button2.Enabled := false;
form1.Button3.Enabled := false;
form1.Button4.Enabled := false;
form1.Button5.Enabled := false;
form1.Button6.Enabled := false;
form1.Button7.Enabled := false;
ScanInOut;
form1.Button1.Enabled := true;
form1.Button2.Enabled := true;
form1.Button3.Enabled := true;
form1.Button4.Enabled := true;
form1.Button5.Enabled := true;
form1.Button6.Enabled := true;
form1.Button7.Enabled := true;

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
form1.Button1.Enabled := false;
form1.Button2.Enabled := false;
form1.Button3.Enabled := false;
form1.Button4.Enabled := false;
form1.Button5.Enabled := false;
form1.Button6.Enabled := false;
form1.Button7.Enabled := false;
OpenDevice;
form1.Button1.Enabled := true;
form1.Button2.Enabled := true;
form1.Button3.Enabled := true;
form1.Button4.Enabled := true;
form1.Button5.Enabled := true;
form1.Button6.Enabled := true;
form1.Button7.Enabled := true;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
form1.Button1.Enabled := false;
form1.Button2.Enabled := false;
form1.Button3.Enabled := false;
form1.Button4.Enabled := false;
form1.Button5.Enabled := false;
form1.Button6.Enabled := false;
form1.Button7.Enabled := false;
ClosePort;
DispMsg('Port Closed');
form1.Button1.Enabled := true;
form1.Button2.Enabled := true;
form1.Button3.Enabled := true;
form1.Button4.Enabled := true;
form1.Button5.Enabled := true;
form1.Button6.Enabled := true;
form1.Button7.Enabled := true;

end;

procedure TForm1.Button6Click(Sender: TObject);
begin
form1.Button1.Enabled := false;
form1.Button2.Enabled := false;
form1.Button3.Enabled := false;
form1.Button4.Enabled := false;
form1.Button5.Enabled := false;
form1.Button6.Enabled := false;
form1.Button7.Enabled := false;
UpdateLowIO;
form1.Button1.Enabled := true;
form1.Button2.Enabled := true;
form1.Button3.Enabled := true;
form1.Button4.Enabled := true;
form1.Button5.Enabled := true;
form1.Button6.Enabled := true;
form1.Button7.Enabled := true;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
form1.Button1.Enabled := false;
form1.Button2.Enabled := false;
form1.Button3.Enabled := false;
form1.Button4.Enabled := false;
form1.Button5.Enabled := false;
form1.Button6.Enabled := false;
form1.Button7.Enabled := false;
UpdateHighIO;
form1.Button1.Enabled := true;
form1.Button2.Enabled := true;
form1.Button3.Enabled := true;
form1.Button4.Enabled := true;
form1.Button5.Enabled := true;
form1.Button6.Enabled := true;
form1.Button7.Enabled := true;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  W_HighPins($00, $30);
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  W_HighPins($30, $30);
end;

end.
