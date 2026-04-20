object fGeradorSQL: TfGeradorSQL
  Left = 500
  Top = 200
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Gerador de SQL'
  ClientHeight = 257
  ClientWidth = 676
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  TextHeight = 13
  object lblColunas: TLabel
    Left = 8
    Top = 5
    Width = 96
    Height = 13
    Caption = 'Colunas (1 por linha)'
  end
  object lblTabelas: TLabel
    Left = 199
    Top = 5
    Width = 48
    Height = 13
    Caption = 'Tabela (1)'
  end
  object lblCondicoes: TLabel
    Left = 390
    Top = 5
    Width = 100
    Height = 13
    Caption = 'Condicoes (WHERE)'
  end
  object lblSqlGerado: TLabel
    Left = 8
    Top = 119
    Width = 59
    Height = 13
    Caption = 'SQL Gerado'
  end
  object memColunas: TMemo
    Left = 8
    Top = 24
    Width = 185
    Height = 89
    TabOrder = 0
  end
  object memTabelas: TMemo
    Left = 199
    Top = 24
    Width = 185
    Height = 89
    TabOrder = 1
  end
  object memCondicoes: TMemo
    Left = 390
    Top = 24
    Width = 185
    Height = 89
    TabOrder = 2
  end
  object memSQLGerado: TMemo
    Left = 8
    Top = 138
    Width = 659
    Height = 111
    TabStop = False
    ReadOnly = True
    TabOrder = 3
  end
  object btnGeraSQL: TButton
    Left = 592
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Gerar SQL'
    TabOrder = 4
    TabStop = False
    OnClick = btnGeraSQLClick
  end
end
