object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Andre says Hello...'
  ClientHeight = 427
  ClientWidth = 610
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ruut: TShape
    Left = 200
    Top = 48
    Width = 97
    Height = 273
    Brush.Color = clRed
    Pen.Color = clGreen
    OnMouseDown = ruutMouseDown
    OnMouseEnter = ruutMouseEnter
    OnMouseLeave = ruutMouseLeave
    OnMouseUp = ruutMouseUp
  end
  object ring: TShape
    Left = 384
    Top = 152
    Width = 121
    Height = 193
    Brush.Color = clBlue
    Shape = stEllipse
    OnMouseDown = ringMouseDown
    OnMouseUp = ringMouseUp
  end
  object kolla: TShape
    Left = 512
    Top = 32
    Width = 65
    Height = 65
    Brush.Color = clYellow
  end
  object alarm: TShape
    Left = 32
    Top = 144
    Width = 65
    Height = 65
    Brush.Color = clGreen
    OnMouseEnter = alarmMouseEnter
    OnMouseLeave = alarmMouseLeave
  end
end
