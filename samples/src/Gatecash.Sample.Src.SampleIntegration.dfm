object FrmSampleIntegration: TFrmSampleIntegration
  Left = 0
  Top = 0
  Caption = 'Sample Integration'
  ClientHeight = 297
  ClientWidth = 643
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 0
    Top = 0
    Width = 643
    Height = 25
    Align = alTop
    Caption = 'Inicializar Comunica'#231#227'o'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 0
    Top = 25
    Width = 643
    Height = 25
    Align = alTop
    Caption = 'Abrir PDV'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 0
    Top = 50
    Width = 643
    Height = 25
    Align = alTop
    Caption = 'Informar Operador'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 0
    Top = 75
    Width = 643
    Height = 25
    Align = alTop
    Caption = 'Finalizar Comunica'#231#227'o'
    TabOrder = 3
    OnClick = Button4Click
  end
end
