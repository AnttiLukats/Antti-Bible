object Form1: TForm1
  Left = 404
  Top = 171
  Caption = 'FTDI UA EEPROM Tool version 1.0'
  ClientHeight = 668
  ClientWidth = 753
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 643
    Width = 753
    Height = 25
    Panels = <
      item
        Width = 200
      end
      item
        Width = 200
      end
      item
        Bevel = pbNone
        Width = 50
      end>
    ExplicitLeft = -48
    ExplicitTop = 645
    ExplicitWidth = 993
  end
  object Panel1: TPanel
    Left = 0
    Top = 25
    Width = 753
    Height = 618
    Align = alClient
    TabOrder = 1
    ExplicitTop = 80
    ExplicitWidth = 993
    ExplicitHeight = 590
    object Memo1: TMemo
      Left = 9
      Top = 6
      Width = 736
      Height = 329
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      Lines.Strings = (
        'Memo1')
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object ListView1: TListView
      Left = 9
      Top = 341
      Width = 737
      Height = 108
      Columns = <
        item
          Caption = 'Device Number'
          Width = 100
        end
        item
          Caption = 'Serial Number'
          Width = 120
        end
        item
          Caption = 'Device Description'
          Width = 200
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      GridLines = True
      Items.ItemData = {
        05440000000200000000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF000000
        00084400650076006900630065002000310000000000FFFFFFFFFFFFFFFF0000
        0000FFFFFFFF0000000000}
      ReadOnly = True
      RowSelect = True
      ParentFont = False
      TabOrder = 1
      ViewStyle = vsReport
      OnClick = ListView1Click
    end
    object Memo2: TMemo
      Left = 9
      Top = 455
      Width = 736
      Height = 224
      Lines.Strings = (
        
          'This tool allows the User EEPROM memory of FTDI USB Devices to b' +
          'e read from the device and written back. '
        'Only plain raw binary file format, 256 long.'
        
          'Autoconnection to first found FTDI device, please disconnect all' +
          ' other FTDI based USB gadgets!'
        ''
        
          'Notice: All FTDI own Support tools do AUTO ERASE silently the Us' +
          'er EEPROM Content!'
        ''
        
          'FTDI UA EEPROM Tool can help to restore the content should you a' +
          'ccidentially erase it.'
        ''
        'Please always read the EEPROM first!'
        
          'Then save it, and verify the content being plausible before writ' +
          'ing to the FTDI device.')
      ReadOnly = True
      TabOrder = 2
    end
  end
  object ActionMainMenuBar1: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 753
    Height = 25
    ActionManager = ActionManager1
    Caption = 'ActionMainMenuBar1'
    Color = clMenuBar
    ColorMap.DisabledFontColor = 7171437
    ColorMap.HighlightColor = clWhite
    ColorMap.BtnSelectedFont = clBlack
    ColorMap.UnusedColor = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Spacing = 0
    ExplicitTop = -15
    ExplicitWidth = 991
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 336
    Top = 48
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Items = <
              item
                Action = FileOpen1
                ImageIndex = 7
                ShortCut = 16463
              end
              item
                Action = FileSaveAs1
                ImageIndex = 30
              end
              item
                Action = FileExit1
                ImageIndex = 43
              end>
            Caption = '&File'
          end>
      end
      item
        Items = <
          item
            Items = <
              item
                Action = FileOpen1
                ImageIndex = 7
                ShortCut = 16463
              end
              item
                Action = FileSaveAs1
                ImageIndex = 30
              end
              item
                Action = FileExit1
                ImageIndex = 43
              end>
            Caption = '&File'
          end
          item
            Items = <
              item
                Action = Action1
                Caption = '&Read User EEPROM'
              end
              item
                Action = Action2
                Caption = '&Write User EEPROM'
              end>
            Caption = 'F&TDI'
          end
          item
            Items = <
              item
                Action = Action3
                Caption = '&About'
              end>
            Caption = '&Help'
          end>
        ActionBar = ActionMainMenuBar1
      end>
    Left = 248
    Top = 48
    StyleName = 'Platform Default'
    object FileOpen1: TFileOpen
      Category = 'File'
      Caption = '&Open...'
      Dialog.DefaultExt = 'bin'
      Dialog.Filter = 'Binary files (*.bin)|*.bin|Any file (*.*)|*.*'
      Dialog.Title = 'Load User EEPROM Image from plain binary'
      Hint = 'Open|Opens an existing file'
      ImageIndex = 7
      ShortCut = 16463
      OnAccept = FileOpen1Accept
    end
    object FileSaveAs1: TFileSaveAs
      Category = 'File'
      Caption = 'Save &As...'
      Dialog.DefaultExt = 'bin'
      Dialog.Filter = 'Binary files (*.bin)|*.bin'
      Dialog.Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofNoTestFileCreate, ofEnableSizing]
      Dialog.Title = 'Save User EEPROM as plain binary'
      Hint = 'Save As|Saves the active file with a new name'
      ImageIndex = 30
      OnAccept = FileSaveAs1Accept
    end
    object FileExit1: TFileExit
      Category = 'File'
      Caption = 'E&xit'
      Hint = 'Exit|Quits the application'
      ImageIndex = 43
    end
    object Action1: TAction
      Category = 'FTDI'
      Caption = 'Read User EEPROM'
      OnExecute = Action1Execute
    end
    object Action2: TAction
      Category = 'FTDI'
      Caption = 'Write User EEPROM'
      OnExecute = Action2Execute
    end
    object Action3: TAction
      Category = 'Help'
      Caption = 'About'
      OnExecute = Action3Execute
    end
  end
end
