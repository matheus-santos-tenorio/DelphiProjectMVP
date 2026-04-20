object fProjetosTotalDivisoes: TfProjetosTotalDivisoes
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Projetos: Total e Divisoes'
  ClientHeight = 316
  ClientWidth = 536
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 13
  object lblValProjeto: TLabel
    Left = 8
    Top = 8
    Width = 96
    Height = 13
    Caption = 'Valores por projeto:'
  end
  object lblTotal: TLabel
    Left = 408
    Top = 232
    Width = 44
    Height = 13
    Caption = 'Total R$:'
  end
  object lblTotalDivisoes: TLabel
    Left = 408
    Top = 276
    Width = 85
    Height = 13
    Caption = 'Total divis'#245'es R$:'
  end
  object btnObtTotal: TButton
    Left = 288
    Top = 249
    Width = 114
    Height = 25
    Caption = 'Obter total'
    TabOrder = 0
    TabStop = False
    OnClick = btnObtTotalClick
  end
  object btnObtTotDivisoes: TButton
    Left = 288
    Top = 284
    Width = 114
    Height = 25
    Caption = 'Obter total divis'#245'es'
    TabOrder = 1
    TabStop = False
    OnClick = btnObtTotDivisoesClick
  end
  object edtTotal: TEdit
    Left = 408
    Top = 251
    Width = 121
    Height = 21
    TabStop = False
    ReadOnly = True
    TabOrder = 2
  end
  object edtTotDivisoes: TEdit
    Left = 408
    Top = 288
    Width = 121
    Height = 21
    TabStop = False
    ReadOnly = True
    TabOrder = 3
  end
  object dbgValProjeto: TDBGrid
    Left = 8
    Top = 27
    Width = 521
    Height = 201
    TabStop = False
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'IdProjeto'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NomeProjeto'
        Width = 361
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Valor'
        Width = 60
        Visible = True
      end>
  end
end
