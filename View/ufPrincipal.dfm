object fPrincipal: TfPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Principal'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = mmFuncionalidades
  Position = poMainFormCenter
  WindowState = wsMaximized
  TextHeight = 13
  object mmFuncionalidades: TMainMenu
    Left = 48
    Top = 16
    object miFuncionalidades: TMenuItem
      Caption = 'Funcionalidades'
      object miGeradorSQL: TMenuItem
        Caption = 'Gerador de SQL'
        OnClick = miGeradorSQLClick
      end
      object miCarregamentoParalelo: TMenuItem
        Caption = 'Carregamento Paralelo'
        OnClick = miCarregamentoParaleloClick
      end
      object miProjetosTotalDivisoes: TMenuItem
        Caption = 'Projetos: Total e Divisoes'
        OnClick = miProjetosTotalDivisoesClick
      end
      object miSimulaoAPI: TMenuItem
        Caption = 'Simula'#231#227'o API'
        OnClick = miSimulaoAPIClick
      end
    end
  end
end
