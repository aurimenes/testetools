object frmCadServico: TfrmCadServico
  Left = 0
  Top = 0
  Caption = 'Cadastro de Servi'#231'o'
  ClientHeight = 326
  ClientWidth = 425
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 90
    Height = 13
    Caption = 'C'#243'digo do Servi'#231'o:'
  end
  object lblCodServico: TLabel
    Left = 115
    Top = 8
    Width = 7
    Height = 13
    Caption = '1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 30
    Width = 68
    Height = 13
    Caption = 'Farmac'#234'utico:'
  end
  object Label3: TLabel
    Left = 8
    Top = 57
    Width = 45
    Height = 13
    Caption = 'Paciente:'
  end
  object Label4: TLabel
    Left = 8
    Top = 84
    Width = 55
    Height = 13
    Caption = 'Valor Total:'
  end
  object lblValorTotal: TLabel
    Left = 115
    Top = 84
    Width = 7
    Height = 13
    Caption = '1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 8
    Top = 111
    Width = 67
    Height = 13
    Caption = 'Observa'#231#245'es:'
  end
  object cmbFarmaceutico: TComboBox
    Left = 115
    Top = 27
    Width = 302
    Height = 21
    Style = csDropDownList
    TabOrder = 0
  end
  object cmbPaciente: TComboBox
    Left = 115
    Top = 54
    Width = 302
    Height = 21
    Style = csDropDownList
    TabOrder = 1
  end
  object StringGrid1: TStringGrid
    Left = 8
    Top = 167
    Width = 409
    Height = 120
    TabOrder = 2
  end
  object Button1: TButton
    Left = 261
    Top = 293
    Width = 75
    Height = 25
    Caption = 'Gravar'
    TabOrder = 3
    OnClick = Button1Click
  end
  object memObservacoes: TMemo
    Left = 115
    Top = 103
    Width = 302
    Height = 58
    TabOrder = 4
  end
  object btnCancelar: TButton
    Left = 342
    Top = 293
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 5
    OnClick = btnCancelarClick
  end
end
