object Form1: TForm1
  Left = 192
  Top = 107
  Caption = 'JTAG Scanning Example'
  ClientHeight = 622
  ClientWidth = 511
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 369
    Height = 49
    TabOrder = 0
    object Label1: TLabel
      Left = 155
      Top = 5
      Width = 66
      Height = 13
      Caption = 'Speed Divisor'
    end
    object Label2: TLabel
      Left = 8
      Top = 5
      Width = 65
      Height = 13
      Caption = 'Device Name'
    end
    object ComboBox1: TComboBox
      Left = 8
      Top = 20
      Width = 145
      Height = 21
      TabOrder = 0
      OnDropDown = ComboBox1DropDown
    end
    object Edit1: TEdit
      Left = 160
      Top = 20
      Width = 41
      Height = 21
      TabOrder = 1
      Text = '0'
      OnChange = Edit1Change
    end
    object Button4: TButton
      Left = 208
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Open'
      TabOrder = 2
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 288
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Close'
      TabOrder = 3
      OnClick = Button5Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 56
    Width = 369
    Height = 289
    TabOrder = 1
    object Label6: TLabel
      Left = 152
      Top = 12
      Width = 92
      Height = 13
      Caption = 'Register To Scan : '
    end
    object Label7: TLabel
      Left = 8
      Top = 12
      Width = 67
      Height = 13
      Caption = 'Output Data : '
    end
    object Label8: TLabel
      Left = 8
      Top = 48
      Width = 80
      Height = 13
      Caption = 'Number Of Bits : '
    end
    object ComboBox3: TComboBox
      Left = 248
      Top = 10
      Width = 73
      Height = 21
      ItemIndex = 1
      TabOrder = 0
      Text = 'Instruction'
      Items.Strings = (
        'Data'
        'Instruction')
    end
    object Button1: TButton
      Left = 16
      Top = 80
      Width = 75
      Height = 25
      Caption = 'Scan In'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Edit2: TEdit
      Left = 80
      Top = 10
      Width = 65
      Height = 21
      TabOrder = 2
      Text = '00 00 00 00'
    end
    object Button2: TButton
      Left = 112
      Top = 80
      Width = 75
      Height = 25
      Caption = 'Scan Out'
      TabOrder = 3
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 208
      Top = 80
      Width = 75
      Height = 25
      Caption = 'Scan In / Out'
      TabOrder = 4
      OnClick = Button3Click
    end
    object Edit3: TEdit
      Left = 90
      Top = 44
      Width = 31
      Height = 21
      TabOrder = 5
      Text = '32'
      OnChange = Edit3Change
    end
    object Memo1: TMemo
      Left = 16
      Top = 112
      Width = 345
      Height = 169
      Lines.Strings = (
        '')
      ScrollBars = ssVertical
      TabOrder = 6
    end
  end
  object Panel3: TPanel
    Left = 376
    Top = 0
    Width = 137
    Height = 169
    TabOrder = 2
    object Label3: TLabel
      Left = 8
      Top = 8
      Width = 73
      Height = 13
      Caption = 'GPIOL 1-4 Pins'
    end
    object Label4: TLabel
      Left = 8
      Top = 24
      Width = 12
      Height = 13
      Caption = 'Bit'
    end
    object Label5: TLabel
      Left = 8
      Top = 41
      Width = 6
      Height = 13
      Caption = '1'
    end
    object Label9: TLabel
      Left = 8
      Top = 57
      Width = 6
      Height = 13
      Caption = '2'
    end
    object Label10: TLabel
      Left = 8
      Top = 73
      Width = 6
      Height = 13
      Caption = '3'
    end
    object Label11: TLabel
      Left = 8
      Top = 89
      Width = 6
      Height = 13
      Caption = '4'
    end
    object Label12: TLabel
      Left = 56
      Top = 115
      Width = 56
      Height = 13
      Caption = 'Value Read'
    end
    object CheckBox1: TCheckBox
      Left = 24
      Top = 40
      Width = 57
      Height = 17
      Caption = 'Output'
      TabOrder = 0
    end
    object CheckBox2: TCheckBox
      Left = 24
      Top = 56
      Width = 57
      Height = 17
      Caption = 'Output'
      TabOrder = 1
    end
    object CheckBox3: TCheckBox
      Left = 24
      Top = 72
      Width = 57
      Height = 17
      Caption = 'Output'
      TabOrder = 2
    end
    object CheckBox4: TCheckBox
      Left = 24
      Top = 88
      Width = 57
      Height = 17
      Caption = 'Output'
      TabOrder = 3
    end
    object CheckBox5: TCheckBox
      Left = 88
      Top = 40
      Width = 44
      Height = 17
      Caption = 'High'
      TabOrder = 4
    end
    object CheckBox6: TCheckBox
      Left = 88
      Top = 56
      Width = 44
      Height = 17
      Caption = 'High'
      TabOrder = 5
    end
    object CheckBox7: TCheckBox
      Left = 88
      Top = 72
      Width = 44
      Height = 17
      Caption = 'High'
      TabOrder = 6
    end
    object CheckBox8: TCheckBox
      Left = 88
      Top = 88
      Width = 44
      Height = 17
      Caption = 'High'
      TabOrder = 7
    end
    object Button6: TButton
      Left = 16
      Top = 136
      Width = 75
      Height = 25
      Caption = 'Update Low'
      TabOrder = 8
      OnClick = Button6Click
    end
    object Edit4: TEdit
      Left = 16
      Top = 112
      Width = 33
      Height = 21
      TabOrder = 9
      Text = '0'
    end
  end
  object Panel4: TPanel
    Left = 375
    Top = 175
    Width = 137
    Height = 370
    TabOrder = 3
    object Label13: TLabel
      Left = 8
      Top = 8
      Width = 75
      Height = 13
      Caption = 'GPIOH 1-4 Pins'
    end
    object Label14: TLabel
      Left = 8
      Top = 24
      Width = 12
      Height = 13
      Caption = 'Bit'
    end
    object Label15: TLabel
      Left = 8
      Top = 41
      Width = 6
      Height = 13
      Caption = '1'
    end
    object Label16: TLabel
      Left = 8
      Top = 57
      Width = 6
      Height = 13
      Caption = '2'
    end
    object Label17: TLabel
      Left = 8
      Top = 73
      Width = 6
      Height = 13
      Caption = '3'
    end
    object Label18: TLabel
      Left = 8
      Top = 89
      Width = 6
      Height = 13
      Caption = '4'
    end
    object Label19: TLabel
      Left = 56
      Top = 210
      Width = 56
      Height = 13
      Caption = 'Value Read'
    end
    object CheckBox9: TCheckBox
      Left = 24
      Top = 40
      Width = 57
      Height = 17
      Caption = 'Output'
      TabOrder = 0
    end
    object CheckBox10: TCheckBox
      Left = 24
      Top = 56
      Width = 57
      Height = 17
      Caption = 'Output'
      TabOrder = 1
    end
    object CheckBox11: TCheckBox
      Left = 24
      Top = 72
      Width = 57
      Height = 17
      Caption = 'Output'
      TabOrder = 2
    end
    object CheckBox12: TCheckBox
      Left = 24
      Top = 88
      Width = 57
      Height = 17
      Caption = 'Output'
      TabOrder = 3
    end
    object CheckBox13: TCheckBox
      Left = 88
      Top = 40
      Width = 44
      Height = 17
      Caption = 'High'
      TabOrder = 4
    end
    object CheckBox14: TCheckBox
      Left = 88
      Top = 56
      Width = 44
      Height = 17
      Caption = 'High'
      TabOrder = 5
    end
    object CheckBox15: TCheckBox
      Left = 88
      Top = 72
      Width = 44
      Height = 17
      Caption = 'High'
      TabOrder = 6
    end
    object CheckBox16: TCheckBox
      Left = 88
      Top = 88
      Width = 44
      Height = 17
      Caption = 'High'
      TabOrder = 7
    end
    object Button7: TButton
      Left = 16
      Top = 231
      Width = 75
      Height = 25
      Caption = 'Update High'
      TabOrder = 8
      OnClick = Button7Click
    end
    object Edit5: TEdit
      Left = 16
      Top = 207
      Width = 33
      Height = 21
      TabOrder = 9
      Text = '0'
    end
  end
  object Button8: TButton
    Left = 96
    Top = 400
    Width = 75
    Height = 25
    Caption = 'RST 0'
    TabOrder = 4
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 177
    Top = 400
    Width = 75
    Height = 25
    Caption = 'RST 1'
    TabOrder = 5
    OnClick = Button9Click
  end
end
