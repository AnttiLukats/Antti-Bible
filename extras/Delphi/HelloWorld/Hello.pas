unit Hello;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TForm2 = class(TForm)
    ruut: TShape;
    ring: TShape;
    kolla: TShape;
    alarm: TShape;
    procedure ruutMouseEnter(Sender: TObject);
    procedure ruutMouseLeave(Sender: TObject);
    procedure ruutMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ruutMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ringMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ringMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure alarmMouseEnter(Sender: TObject);
    procedure alarmMouseLeave(Sender: TObject);
    procedure ringMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
{$R *.dfm}



procedure TForm2.alarmMouseEnter(Sender: TObject);
begin
kolla.Brush.Color := clGreen;
alarm.Brush.Color := clYellow;
end;

procedure TForm2.alarmMouseLeave(Sender: TObject);
begin
kolla.Brush.Color := clYellow;
alarm.Brush.Color := clGreen;
end;

procedure TForm2.ringMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
kolla.Top := kolla.Top - 10;
end;

procedure TForm2.ringMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
kolla.Top := kolla.Top - 10;
end;

procedure TForm2.ringMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
kolla.Top := kolla.Top + 10;
end;

procedure TForm2.ruutMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
kolla.Left := kolla.Left - 20;
end;

procedure TForm2.ruutMouseEnter(Sender: TObject);
begin
ruut.Brush.Color := clBlue;
ring.Brush.Color := clRed;

end;

procedure TForm2.ruutMouseLeave(Sender: TObject);
begin
ruut.Brush.Color := clRed;
ring.Brush.Color := clBlue;
end;

procedure TForm2.ruutMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
kolla.Left := kolla.Left + 20;
end;

end.
