object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 813
  ClientWidth = 1140
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblF: TLabel
    Left = 704
    Top = 96
    Width = 22
    Height = 13
    Caption = 'Freq'
  end
  object SLScope1: TSLScope
    Left = 8
    Top = 582
    Width = 329
    Height = 227
    TabOrder = 0
    InputPins.Form = Form2
    InputPins.Pins = (
      Form2.LO_I.OutputPin
      Form2.LO_Q.OutputPin)
    Channels = <
      item
        Name = 'LO I'
        InputPin.Form = Form2
        InputPin.SourcePin = Form2.LO_I.OutputPin
      end
      item
        Name = 'LO Q'
        InputPin.Form = Form2
        InputPin.SourcePin = Form2.LO_Q.OutputPin
      end>
  end
  object SLScope2: TSLScope
    Left = 8
    Top = 224
    Width = 1129
    Height = 352
    TabOrder = 1
    InputPins.Form = Form2
    InputPins.Pins = (
      Form2.MIX2_I.OutputPin
      Form2.MIX2_Q.OutputPin
      Form2.sumout.OutputPin)
    XAxis.Max.AutoScale = False
    XAxis.Max.Value = 32768.000000000000000000
    XAxis.Max.DataValue = 32768.000000000000000000
    XAxis.MaxSample.Autosize = False
    XAxis.MaxSample.Value = 32768
    Channels = <
      item
        Name = 'DEM I'
        InputPin.Form = Form2
        InputPin.SourcePin = Form2.MIX2_I.OutputPin
      end
      item
        Name = 'DEM Q'
        InputPin.Form = Form2
        InputPin.SourcePin = Form2.MIX2_Q.OutputPin
      end
      item
        Name = 'Audio'
        InputPin.Form = Form2
        InputPin.SourcePin = Form2.sumout.OutputPin
      end>
  end
  object BitBtn1: TBitBtn
    Left = 704
    Top = 24
    Width = 75
    Height = 25
    Caption = '+'
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 704
    Top = 55
    Width = 75
    Height = 25
    Caption = '-'
    TabOrder = 3
    OnClick = BitBtn2Click
  end
  object SLScope3: TSLScope
    Left = 343
    Top = 582
    Width = 794
    Height = 227
    TabOrder = 4
    InputPins.Form = Form2
    InputPins.Pins = (
      Form2.SLFourier1.SpectrumOutputPin)
    YAxis.ScaleMode = smLogarithmic
    Channels = <
      item
        Name = 'Channel0'
        InputPin.Form = Form2
        InputPin.SourcePin = Form2.SLFourier1.SpectrumOutputPin
      end>
  end
  object LO_I: TSLSignalGen
    ClockPin.Form = Form2
    ClockPin.SourcePins = (
      Form2.refclock.OutputPin)
    ClockSource = csExternal
    SampleRate = 25000000.000000000000000000
    BufferSize = 32768
    OutputPin.Form = Form2
    OutputPin.SinkPins = (
      (
        Form2.SLScope1.InputPins._Pin0
        'Form2.SLScope1.InputPins.LO I')
      (
        Form2.MIX_I.InputPins._Pin1
        'Form2.MIX_I.InputPins.Pin [1]'))
    Frequency = 1800300.000000000000000000
    Left = 296
    Top = 112
  end
  object LO_Q: TSLSignalGen
    ClockPin.Form = Form2
    ClockPin.SourcePins = (
      Form2.refclock.OutputPin)
    ClockSource = csExternal
    SampleRate = 25000000.000000000000000000
    BufferSize = 32768
    OutputPin.Form = Form2
    OutputPin.SinkPins = (
      (
        Form2.SLScope1.InputPins._Pin1
        'Form2.SLScope1.InputPins.LO Q')
      (
        Form2.MIX_Q.InputPins._Pin1
        'Form2.MIX_Q.InputPins.Pin [1]'))
    Phase = 2.035406611999980000
    Frequency = 1800300.000000000000000000
    Left = 296
    Top = 160
  end
  object signal: TSLSignalGen
    ClockPin.Form = Form2
    ClockPin.SourcePins = (
      Form2.refclock.OutputPin)
    ClockSource = csExternal
    SampleRate = 25000000.000000000000000000
    BufferSize = 32768
    OutputPin.Form = Form2
    OutputPin.SinkPins = (
      (
        Form2.MIX_I.InputPins._Pin0
        'Form2.MIX_I.InputPins.Pin [0]')
      (
        Form2.MIX_Q.InputPins._Pin0
        'Form2.MIX_Q.InputPins.Pin [0]'))
    Amplitude = 150.000000000000000000
    Frequency = 1800600.000000000000000000
    Left = 168
    Top = 8
  end
  object MIX_I: TSLMultiply
    OutputPin.Form = Form2
    OutputPin.SinkPins = (
      Form2.LP_I.InputPin)
    InputPins.Form = Form2
    InputPins.Pins = (
      Form2.signal.OutputPin
      Form2.LO_I.OutputPin)
    Left = 328
    Top = 8
  end
  object MIX_Q: TSLMultiply
    OutputPin.Form = Form2
    OutputPin.SinkPins = (
      Form2.LP_Q.InputPin)
    InputPins.Form = Form2
    InputPins.Pins = (
      Form2.signal.OutputPin
      Form2.LO_Q.OutputPin)
    Left = 328
    Top = 64
  end
  object LP_I: TSLLowPass
    OutputPin.Form = Form2
    OutputPin.SinkPins = (
      (
        Form2.MIX2_I.InputPins._Pin0
        'Form2.MIX2_I.InputPins.Pin [0]'))
    InputPin.Form = Form2
    InputPin.SourcePin = Form2.MIX_I.OutputPin
    Order = 101
    FilterType = ftBiquadIIR
    IIRFilterType = iirBessel
    Frequency = 350.000000000000000000
    Left = 392
    Top = 8
  end
  object LP_Q: TSLLowPass
    OutputPin.Form = Form2
    OutputPin.SinkPins = (
      (
        Form2.MIX2_Q.InputPins._Pin0
        'Form2.MIX2_Q.InputPins.Pin [0]'))
    InputPin.Form = Form2
    InputPin.SourcePin = Form2.MIX_Q.OutputPin
    Order = 101
    FilterType = ftBiquadIIR
    IIRFilterType = iirBessel
    Frequency = 350.000000000000000000
    Left = 392
    Top = 64
  end
  object refclock: TTLClockGen
    OutputPin.Form = Form2
    OutputPin.SinkPins = (
      Form2.signal.ClockPin
      Form2.LO_Q.ClockPin
      Form2.LO_I.ClockPin
      Form2.WO_I.ClockPin
      Form2.WO_Q.ClockPin)
    Left = 168
    Top = 112
  end
  object MIX2_I: TSLMultiply
    OutputPin.Form = Form2
    OutputPin.SinkPins = (
      (
        Form2.SLScope2.InputPins._Pin0
        'Form2.SLScope2.InputPins.DEM I')
      (
        Form2.sumout.InputPins._Pin0
        'Form2.sumout.InputPins.Pin [0]'))
    InputPins.Form = Form2
    InputPins.Pins = (
      Form2.LP_I.OutputPin
      Form2.WO_I.OutputPin)
    Left = 456
    Top = 8
  end
  object MIX2_Q: TSLMultiply
    OutputPin.Form = Form2
    OutputPin.SinkPins = (
      (
        Form2.SLScope2.InputPins._Pin1
        'Form2.SLScope2.InputPins.DEM Q')
      (
        Form2.sumout.InputPins._Pin1
        'Form2.sumout.InputPins.Pin [1]'))
    InputPins.Form = Form2
    InputPins.Pins = (
      Form2.LP_Q.OutputPin
      Form2.WO_Q.OutputPin)
    Left = 456
    Top = 64
  end
  object sumout: TSLAdd
    OutputPin.Form = Form2
    OutputPin.SinkPins = (
      (
        Form2.SLScope2.InputPins._Pin2
        'Form2.SLScope2.InputPins.Audio')
      Form2.SLFourier1.InputPin)
    InputPins.Form = Form2
    InputPins.Pins = (
      Form2.MIX2_I.OutputPin
      Form2.MIX2_Q.OutputPin)
    Left = 512
    Top = 40
  end
  object WO_I: TSLSignalGen
    ClockPin.Form = Form2
    ClockPin.SourcePins = (
      Form2.refclock.OutputPin)
    ClockSource = csExternal
    SampleRate = 25000000.000000000000000000
    BufferSize = 32768
    OutputPin.Form = Form2
    OutputPin.SinkPins = (
      (
        Form2.MIX2_I.InputPins._Pin1
        'Form2.MIX2_I.InputPins.Pin [1]'))
    Frequency = 300.000000000000000000
    Left = 432
    Top = 112
  end
  object WO_Q: TSLSignalGen
    ClockPin.Form = Form2
    ClockPin.SourcePins = (
      Form2.refclock.OutputPin)
    ClockSource = csExternal
    SampleRate = 25000000.000000000000000000
    BufferSize = 32768
    OutputPin.Form = Form2
    OutputPin.SinkPins = (
      (
        Form2.MIX2_Q.InputPins._Pin1
        'Form2.MIX2_Q.InputPins.Pin [1]'))
    Phase = 2.035406611999980000
    Frequency = 300.000000000000000000
    Left = 432
    Top = 160
  end
  object SLFourier1: TSLFourier
    InputPin.Form = Form2
    InputPin.SourcePin = Form2.sumout.OutputPin
    SpectrumOutputPin.Form = Form2
    SpectrumOutputPin.SinkPins = (
      (
        Form2.SLScope3.InputPins._Pin0
        'Form2.SLScope3.InputPins.Channel0'))
    IgnoreDC = True
    WindowType = xwtHamming
    Order = 21
    Normalization = fnNormalize
    Left = 560
    Top = 40
  end
end
