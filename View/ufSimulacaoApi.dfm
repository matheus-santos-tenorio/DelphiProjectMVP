object fSimulacaoApi: TfSimulacaoApi
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Simula'#231#227'o API'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object btnBuscaEnd: TButton
    Left = 15
    Top = 26
    Width = 114
    Height = 25
    Caption = 'Buscar Endere'#231'o'
    TabOrder = 0
    TabStop = False
    OnClick = btnBuscaEndClick
  end
  object edtBuscarCep: TEdit
    Left = 135
    Top = 27
    Width = 121
    Height = 24
    TabStop = False
    ReadOnly = True
    TabOrder = 1
  end
  object memEndereco: TMemo
    Left = 15
    Top = 57
    Width = 241
    Height = 224
    TabOrder = 2
  end
end
