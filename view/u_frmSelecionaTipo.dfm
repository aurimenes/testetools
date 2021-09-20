object frmSelecionaTipo: TfrmSelecionaTipo
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Selecionar Tipo de Servi'#231'o'
  ClientHeight = 83
  ClientWidth = 279
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
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 5
    Width = 135
    Height = 13
    Caption = 'Selecione o Servi'#231'o a Inserir'
  end
  object cmbTiposServico: TComboBox
    Left = 8
    Top = 24
    Width = 265
    Height = 21
    Style = csDropDownList
    TabOrder = 0
  end
  object Button1: TButton
    Left = 117
    Top = 51
    Width = 75
    Height = 25
    Caption = 'Inserir'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 198
    Top = 51
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 2
    OnClick = Button2Click
  end
end
