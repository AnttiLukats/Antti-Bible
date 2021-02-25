object Form6: TForm6
  Left = 0
  Top = 0
  Caption = 'Trioflex DDS Simulator'
  ClientHeight = 625
  ClientWidth = 830
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ActionMainMenuBar1: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 830
    Height = 25
    UseSystemFont = False
    ActionManager = ActionManager1
    Caption = 'ActionMainMenuBar1'
    Color = clMenuBar
    ColorMap.DisabledFontColor = 7171437
    ColorMap.HighlightColor = clWhite
    ColorMap.BtnSelectedFont = clBlack
    ColorMap.UnusedColor = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Spacing = 0
  end
  object Panel1: TPanel
    Left = 676
    Top = 25
    Width = 154
    Height = 600
    Align = alRight
    TabOrder = 1
    object LabeledEdit1: TLabeledEdit
      Left = 6
      Top = 24
      Width = 121
      Height = 21
      EditLabel.Width = 49
      EditLabel.Height = 13
      EditLabel.Caption = 'Increment'
      TabOrder = 0
      Text = '30000'
      OnChange = LabeledEdit1Change
    end
    object LabeledEdit2: TLabeledEdit
      Left = 8
      Top = 64
      Width = 121
      Height = 21
      EditLabel.Width = 71
      EditLabel.Height = 13
      EditLabel.Caption = 'DDS Clock (Hz)'
      TabOrder = 1
      Text = '500000000'
      OnChange = LabeledEdit2Change
    end
    object LabeledEdit3: TLabeledEdit
      Left = 8
      Top = 104
      Width = 121
      Height = 21
      EditLabel.Width = 61
      EditLabel.Height = 13
      EditLabel.Caption = 'LabeledEdit3'
      TabOrder = 2
    end
    object LabeledEdit4: TLabeledEdit
      Left = 8
      Top = 144
      Width = 121
      Height = 21
      EditLabel.Width = 61
      EditLabel.Height = 13
      EditLabel.Caption = 'LabeledEdit4'
      TabOrder = 3
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 25
    Width = 676
    Height = 600
    Align = alClient
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 1
      Top = 310
      Width = 674
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 178
      ExplicitWidth = 196
    end
    object SLScope1: TSLScope
      Left = 1
      Top = 1
      Width = 674
      Height = 309
      Cursor = crDefault
      Align = alClient
      Title.Align = vaTop
      Title.Text = 'Scope'
      Title.Font.Charset = DEFAULT_CHARSET
      Title.Font.Color = clWhite
      Title.Font.Height = -21
      Title.Font.Name = 'Arial'
      Title.Font.Style = [fsBold]
      Title.AdditionalTitles = <>
      Trails.Font.Charset = DEFAULT_CHARSET
      Trails.Font.Color = clWhite
      Trails.Font.Height = -11
      Trails.Font.Name = 'Arial'
      Trails.Font.Style = []
      TabOrder = 0
      InputPins.Form = Form6
      InputPins.Pins = (
        Form6.SLGenericIntGen1.OutputPin)
      XInputPins.Form = Form6
      YAxis.Align = vaLeft
      YAxis.MajorTicks.Step = 10.000000000000000000
      YAxis.MajorTicks.StartFrom._Floats = (
        (
          StartFrom
          0.000000000000000000))
      YAxis.Format.Precision = 3
      YAxis.Font.Charset = DEFAULT_CHARSET
      YAxis.Font.Color = clWhite
      YAxis.Font.Height = -11
      YAxis.Font.Name = 'Arial'
      YAxis.Font.Style = []
      YAxis.Min.Value = -1000.000000000000000000
      YAxis.Min.DataValue = -1000.000000000000000000
      YAxis.Min.Range.High.Value = 1000.000000000000000000
      YAxis.Min.Range.High.Enabled = False
      YAxis.Min.Range.Low.Value = -1000.000000000000000000
      YAxis.Min.Range.Low.Enabled = False
      YAxis.Min.Tick._Floats = (
        (
          Value
          0.000000000000000000))
      YAxis.Max.Value = 1000.000000000000000000
      YAxis.Max.DataValue = 1000.000000000000000000
      YAxis.Max.Range.High.Value = 1000.000000000000000000
      YAxis.Max.Range.High.Enabled = False
      YAxis.Max.Range.Low.Value = -1000.000000000000000000
      YAxis.Max.Range.Low.Enabled = False
      YAxis.Max.Tick._Floats = (
        (
          Value
          0.000000000000000000))
      YAxis.Zooming.Range.High.Value = 100000000.000000000000000000
      YAxis.Zooming.Range.High.Enabled = False
      YAxis.Zooming.Range.Low.Value = 0.000000100000000000
      YAxis.Zooming.Range.Low.Enabled = True
      YAxis.AxisLabel.Font.Charset = DEFAULT_CHARSET
      YAxis.AxisLabel.Font.Color = clWhite
      YAxis.AxisLabel.Font.Height = -13
      YAxis.AxisLabel.Font.Name = 'Arial'
      YAxis.AxisLabel.Font.Style = [fsBold]
      YAxis.AxisLabel.Text = 'Y Axis'
      YAxis.DataView.Lines.Pen.Color = clGreen
      YAxis.DataView.ZeroLine.Pen.Color = clWhite
      YAxis.AdditionalAxes = <>
      XAxis.Align = vaBottom
      XAxis.MajorTicks.Step = 10.000000000000000000
      XAxis.MajorTicks.StartFrom._Floats = (
        (
          StartFrom
          0.000000000000000000))
      XAxis.Format.Precision = 3
      XAxis.Font.Charset = DEFAULT_CHARSET
      XAxis.Font.Color = clWhite
      XAxis.Font.Height = -11
      XAxis.Font.Name = 'Arial'
      XAxis.Font.Style = []
      XAxis.Min.Range.High.Value = 1000.000000000000000000
      XAxis.Min.Range.High.Enabled = False
      XAxis.Min.Range.Low.Value = -1000.000000000000000000
      XAxis.Min.Range.Low.Enabled = False
      XAxis.Min.Tick._Floats = (
        (
          Value
          0.000000000000000000))
      XAxis.Min._Floats = (
        (
          DataValue
          0.000000000000000000)
        (
          Value
          0.000000000000000000))
      XAxis.Max.Value = 1024.000000000000000000
      XAxis.Max.DataValue = 1024.000000000000000000
      XAxis.Max.Range.High.Value = 1000.000000000000000000
      XAxis.Max.Range.High.Enabled = False
      XAxis.Max.Range.Low.Value = -1000.000000000000000000
      XAxis.Max.Range.Low.Enabled = False
      XAxis.Max.Tick.Value = 1024.000000000000000000
      XAxis.Zooming.Range.High.Value = 100000000.000000000000000000
      XAxis.Zooming.Range.High.Enabled = False
      XAxis.Zooming.Range.Low.Value = 0.000000100000000000
      XAxis.Zooming.Range.Low.Enabled = True
      XAxis.AxisLabel.Font.Charset = DEFAULT_CHARSET
      XAxis.AxisLabel.Font.Color = clWhite
      XAxis.AxisLabel.Font.Height = -13
      XAxis.AxisLabel.Font.Name = 'Arial'
      XAxis.AxisLabel.Font.Style = [fsBold]
      XAxis.DataView.Lines.Pen.Color = clGreen
      XAxis.DataView.ZeroLine.Pen.Color = clWhite
      XAxis.AdditionalAxes = <>
      Legend.Align = vaRight
      Legend.Font.Charset = DEFAULT_CHARSET
      Legend.Font.Color = clWhite
      Legend.Font.Height = -11
      Legend.Font.Name = 'Arial'
      Legend.Font.Style = []
      Legend.MarkerGroups.Caption.Font.Charset = DEFAULT_CHARSET
      Legend.MarkerGroups.Caption.Font.Color = clWhite
      Legend.MarkerGroups.Caption.Font.Height = -13
      Legend.MarkerGroups.Caption.Font.Name = 'Arial'
      Legend.MarkerGroups.Caption.Font.Style = []
      Legend.Cursors.Caption.Font.Charset = DEFAULT_CHARSET
      Legend.Cursors.Caption.Font.Color = clWhite
      Legend.Cursors.Caption.Font.Height = -13
      Legend.Cursors.Caption.Font.Name = 'Arial'
      Legend.Cursors.Caption.Font.Style = []
      Legend.CursorLinks.Caption.Font.Charset = DEFAULT_CHARSET
      Legend.CursorLinks.Caption.Font.Color = clWhite
      Legend.CursorLinks.Caption.Font.Height = -13
      Legend.CursorLinks.Caption.Font.Name = 'Arial'
      Legend.CursorLinks.Caption.Font.Style = []
      Legend.Labels.Caption.Font.Charset = DEFAULT_CHARSET
      Legend.Labels.Caption.Font.Color = clWhite
      Legend.Labels.Caption.Font.Height = -13
      Legend.Labels.Caption.Font.Name = 'Arial'
      Legend.Labels.Caption.Font.Style = []
      Legend.CustomGroups = <>
      Legend.Channels.Caption.Font.Charset = DEFAULT_CHARSET
      Legend.Channels.Caption.Font.Color = clWhite
      Legend.Channels.Caption.Font.Height = -13
      Legend.Channels.Caption.Font.Name = 'Arial'
      Legend.Channels.Caption.Font.Style = []
      Legend.ChannelLinks.Caption.Font.Charset = DEFAULT_CHARSET
      Legend.ChannelLinks.Caption.Font.Color = clWhite
      Legend.ChannelLinks.Caption.Font.Height = -13
      Legend.ChannelLinks.Caption.Font.Name = 'Arial'
      Legend.ChannelLinks.Caption.Font.Style = []
      Legend.Zones.Caption.Font.Charset = DEFAULT_CHARSET
      Legend.Zones.Caption.Font.Color = clWhite
      Legend.Zones.Caption.Font.Height = -13
      Legend.Zones.Caption.Font.Name = 'Arial'
      Legend.Zones.Caption.Font.Style = []
      Legend.Ellipses.Caption.Font.Charset = DEFAULT_CHARSET
      Legend.Ellipses.Caption.Font.Color = clWhite
      Legend.Ellipses.Caption.Font.Height = -13
      Legend.Ellipses.Caption.Font.Name = 'Arial'
      Legend.Ellipses.Caption.Font.Style = []
      DataView.Border.Pen.Color = clGreen
      Highlighting.MouseHitPoint.PointLabel.Font.Charset = DEFAULT_CHARSET
      Highlighting.MouseHitPoint.PointLabel.Font.Color = clWhite
      Highlighting.MouseHitPoint.PointLabel.Font.Height = -11
      Highlighting.MouseHitPoint.PointLabel.Font.Name = 'Arial'
      Highlighting.MouseHitPoint.PointLabel.Font.Style = []
      MarkerGroups = <>
      Channels = <
        item
          Name = 'DDS Out'
          Color = clRed
          Points.Brush.Color = clRed
          Points.Brush.Style = bsSolid
          Points.Pen.Color = clRed
          MouseCursor = crDefault
          InputPin.Form = Form6
          InputPin.SourcePin = Form6.SLGenericIntGen1.OutputPin
          Markers = <>
          AxisIndex_ = (
            0
            0)
        end>
      Zones = <>
      Ellipses = <>
      Cursors = <>
      CursorLinks = <>
      ChannelLinks = <>
      Labels = <>
    end
    object SLScope2: TSLScope
      Left = 1
      Top = 313
      Width = 674
      Height = 286
      Cursor = crDefault
      Align = alBottom
      Title.Align = vaTop
      Title.Text = 'FFT'
      Title.Font.Charset = DEFAULT_CHARSET
      Title.Font.Color = clWhite
      Title.Font.Height = -21
      Title.Font.Name = 'Arial'
      Title.Font.Style = [fsBold]
      Title.AdditionalTitles = <>
      Trails.Font.Charset = DEFAULT_CHARSET
      Trails.Font.Color = clWhite
      Trails.Font.Height = -11
      Trails.Font.Name = 'Arial'
      Trails.Font.Style = []
      TabOrder = 1
      InputPins.Form = Form6
      InputPins.Pins = (
        Form6.SLFourier1.SpectrumOutputPin)
      XInputPins.Form = Form6
      YAxis.Align = vaLeft
      YAxis.MajorTicks.Step = 10.000000000000000000
      YAxis.MajorTicks.StartFrom._Floats = (
        (
          StartFrom
          0.000000000000000000))
      YAxis.Format.Precision = 3
      YAxis.Font.Charset = DEFAULT_CHARSET
      YAxis.Font.Color = clWhite
      YAxis.Font.Height = -11
      YAxis.Font.Name = 'Arial'
      YAxis.Font.Style = []
      YAxis.Min.Value = -1000.000000000000000000
      YAxis.Min.DataValue = -1000.000000000000000000
      YAxis.Min.Range.High.Value = 1000.000000000000000000
      YAxis.Min.Range.High.Enabled = False
      YAxis.Min.Range.Low.Value = -1000.000000000000000000
      YAxis.Min.Range.Low.Enabled = False
      YAxis.Min.Tick._Floats = (
        (
          Value
          0.000000000000000000))
      YAxis.Max.Value = 1000.000000000000000000
      YAxis.Max.DataValue = 1000.000000000000000000
      YAxis.Max.Range.High.Value = 1000.000000000000000000
      YAxis.Max.Range.High.Enabled = False
      YAxis.Max.Range.Low.Value = -1000.000000000000000000
      YAxis.Max.Range.Low.Enabled = False
      YAxis.Max.Tick._Floats = (
        (
          Value
          0.000000000000000000))
      YAxis.Zooming.Range.High.Value = 100000000.000000000000000000
      YAxis.Zooming.Range.High.Enabled = False
      YAxis.Zooming.Range.Low.Value = 0.000000100000000000
      YAxis.Zooming.Range.Low.Enabled = True
      YAxis.AxisLabel.Font.Charset = DEFAULT_CHARSET
      YAxis.AxisLabel.Font.Color = clWhite
      YAxis.AxisLabel.Font.Height = -13
      YAxis.AxisLabel.Font.Name = 'Arial'
      YAxis.AxisLabel.Font.Style = [fsBold]
      YAxis.AxisLabel.Text = 'Y Axis'
      YAxis.DataView.Lines.Pen.Color = clGreen
      YAxis.DataView.ZeroLine.Pen.Color = clWhite
      YAxis.AdditionalAxes = <>
      XAxis.Align = vaBottom
      XAxis.MajorTicks.Step = 10.000000000000000000
      XAxis.MajorTicks.StartFrom._Floats = (
        (
          StartFrom
          0.000000000000000000))
      XAxis.Format.Precision = 3
      XAxis.Font.Charset = DEFAULT_CHARSET
      XAxis.Font.Color = clWhite
      XAxis.Font.Height = -11
      XAxis.Font.Name = 'Arial'
      XAxis.Font.Style = []
      XAxis.Min.Range.High.Value = 1000.000000000000000000
      XAxis.Min.Range.High.Enabled = False
      XAxis.Min.Range.Low.Value = -1000.000000000000000000
      XAxis.Min.Range.Low.Enabled = False
      XAxis.Min.Tick._Floats = (
        (
          Value
          0.000000000000000000))
      XAxis.Min._Floats = (
        (
          DataValue
          0.000000000000000000)
        (
          Value
          0.000000000000000000))
      XAxis.Max.Value = 1024.000000000000000000
      XAxis.Max.DataValue = 1024.000000000000000000
      XAxis.Max.Range.High.Value = 1000.000000000000000000
      XAxis.Max.Range.High.Enabled = False
      XAxis.Max.Range.Low.Value = -1000.000000000000000000
      XAxis.Max.Range.Low.Enabled = False
      XAxis.Max.Tick.Value = 1024.000000000000000000
      XAxis.Zooming.Range.High.Value = 100000000.000000000000000000
      XAxis.Zooming.Range.High.Enabled = False
      XAxis.Zooming.Range.Low.Value = 0.000000100000000000
      XAxis.Zooming.Range.Low.Enabled = True
      XAxis.AxisLabel.Font.Charset = DEFAULT_CHARSET
      XAxis.AxisLabel.Font.Color = clWhite
      XAxis.AxisLabel.Font.Height = -13
      XAxis.AxisLabel.Font.Name = 'Arial'
      XAxis.AxisLabel.Font.Style = [fsBold]
      XAxis.DataView.Lines.Pen.Color = clGreen
      XAxis.DataView.ZeroLine.Pen.Color = clWhite
      XAxis.AdditionalAxes = <>
      Legend.Align = vaRight
      Legend.Font.Charset = DEFAULT_CHARSET
      Legend.Font.Color = clWhite
      Legend.Font.Height = -11
      Legend.Font.Name = 'Arial'
      Legend.Font.Style = []
      Legend.MarkerGroups.Caption.Font.Charset = DEFAULT_CHARSET
      Legend.MarkerGroups.Caption.Font.Color = clWhite
      Legend.MarkerGroups.Caption.Font.Height = -13
      Legend.MarkerGroups.Caption.Font.Name = 'Arial'
      Legend.MarkerGroups.Caption.Font.Style = []
      Legend.Cursors.Caption.Font.Charset = DEFAULT_CHARSET
      Legend.Cursors.Caption.Font.Color = clWhite
      Legend.Cursors.Caption.Font.Height = -13
      Legend.Cursors.Caption.Font.Name = 'Arial'
      Legend.Cursors.Caption.Font.Style = []
      Legend.CursorLinks.Caption.Font.Charset = DEFAULT_CHARSET
      Legend.CursorLinks.Caption.Font.Color = clWhite
      Legend.CursorLinks.Caption.Font.Height = -13
      Legend.CursorLinks.Caption.Font.Name = 'Arial'
      Legend.CursorLinks.Caption.Font.Style = []
      Legend.Labels.Caption.Font.Charset = DEFAULT_CHARSET
      Legend.Labels.Caption.Font.Color = clWhite
      Legend.Labels.Caption.Font.Height = -13
      Legend.Labels.Caption.Font.Name = 'Arial'
      Legend.Labels.Caption.Font.Style = []
      Legend.CustomGroups = <>
      Legend.Channels.Caption.Font.Charset = DEFAULT_CHARSET
      Legend.Channels.Caption.Font.Color = clWhite
      Legend.Channels.Caption.Font.Height = -13
      Legend.Channels.Caption.Font.Name = 'Arial'
      Legend.Channels.Caption.Font.Style = []
      Legend.ChannelLinks.Caption.Font.Charset = DEFAULT_CHARSET
      Legend.ChannelLinks.Caption.Font.Color = clWhite
      Legend.ChannelLinks.Caption.Font.Height = -13
      Legend.ChannelLinks.Caption.Font.Name = 'Arial'
      Legend.ChannelLinks.Caption.Font.Style = []
      Legend.Zones.Caption.Font.Charset = DEFAULT_CHARSET
      Legend.Zones.Caption.Font.Color = clWhite
      Legend.Zones.Caption.Font.Height = -13
      Legend.Zones.Caption.Font.Name = 'Arial'
      Legend.Zones.Caption.Font.Style = []
      Legend.Ellipses.Caption.Font.Charset = DEFAULT_CHARSET
      Legend.Ellipses.Caption.Font.Color = clWhite
      Legend.Ellipses.Caption.Font.Height = -13
      Legend.Ellipses.Caption.Font.Name = 'Arial'
      Legend.Ellipses.Caption.Font.Style = []
      DataView.Border.Pen.Color = clGreen
      Highlighting.MouseHitPoint.PointLabel.Font.Charset = DEFAULT_CHARSET
      Highlighting.MouseHitPoint.PointLabel.Font.Color = clWhite
      Highlighting.MouseHitPoint.PointLabel.Font.Height = -11
      Highlighting.MouseHitPoint.PointLabel.Font.Name = 'Arial'
      Highlighting.MouseHitPoint.PointLabel.Font.Style = []
      MarkerGroups = <>
      Channels = <
        item
          Name = 'DDS Out'
          Color = clRed
          Points.Brush.Color = clRed
          Points.Brush.Style = bsSolid
          Points.Pen.Color = clRed
          MouseCursor = crDefault
          InputPin.Form = Form6
          InputPin.SourcePin = Form6.SLFourier1.SpectrumOutputPin
          Markers = <>
          AxisIndex_ = (
            0
            0)
        end>
      Zones = <>
      Ellipses = <>
      Cursors = <>
      CursorLinks = <>
      ChannelLinks = <>
      Labels = <>
    end
  end
  object SLGenericIntGen1: TSLGenericIntGen
    OnStop = SLGenericIntGen1Stop
    SampleRate = 300000000.000000000000000000
    BufferSize = 8096
    OnStart = SLGenericIntGen1Start
    OutputPin.Form = Form6
    OutputPin.SinkPins = (
      (
        Form6.SLScope1.InputPins._Pin0
        'Form6.SLScope1.InputPins.DDS Out')
      Form6.SLFourier1.InputPin)
    OnGenerate = SLGenericIntGen1Generate
    Left = 184
    Top = 56
  end
  object SLFourier1: TSLFourier
    InputPin.Form = Form6
    InputPin.SourcePin = Form6.SLGenericIntGen1.OutputPin
    SpectrumOutputPin.Form = Form6
    SpectrumOutputPin.SinkPins = (
      (
        Form6.SLScope2.InputPins._Pin0
        'Form6.SLScope2.InputPins.DDS Out'))
    Alpha = 1.000000000000000000
    WindowType = xwtHanning
    Order = 20
    Left = 288
    Top = 56
  end
  object XPManifest1: TXPManifest
    Left = 40
    Top = 24
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Items = <
              item
                Action = FileExit1
                ImageIndex = 43
              end>
            Caption = '&File'
          end>
        ActionBar = ActionMainMenuBar1
      end>
    Left = 40
    Top = 72
    StyleName = 'Platform Default'
    object FileExit1: TFileExit
      Category = 'File'
      Caption = 'E&xit'
      Hint = 'Exit|Quits the application'
      ImageIndex = 43
    end
  end
end
