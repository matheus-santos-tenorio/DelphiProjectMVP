unit Presenter.GeradorSQL;

interface

uses
  System.SysUtils, System.Classes, uspQuery, Presenter.Base, uExceptions, uLogger;

type
  IPresenterGeradorSQL = interface
    ['{A1B2C3D4-E5F6-7890-ABCD-EF1234567890}']
    function GerarSQL(psColunas, psTabelas, psCondicoes: string): string;
  end;

  TPresenterGeradorSQL = class(TBasePresenter, IPresenterGeradorSQL)
  private
    FspQuery: TspQuery;
  public
    constructor Create;
    destructor Destroy; override;

    function GerarSQL(psColunas, psTabelas, psCondicoes: string): string;
  end;

implementation

{ TPresenterGeradorSQL }

constructor TPresenterGeradorSQL.Create;
begin
  inherited;
  FspQuery := TspQuery.Create(nil);
end;

destructor TPresenterGeradorSQL.Destroy;
begin
  FspQuery.Free;
  inherited;
end;

function TPresenterGeradorSQL.GerarSQL(psColunas, psTabelas, psCondicoes: string): string;
begin
  FLogger.LogInfo('Iniciando geração de SQL com colunas: ' + psColunas + ', tabelas: ' + psTabelas);
  try
    FspQuery.GeraSQL(psColunas, psTabelas, psCondicoes);
    Result := FspQuery.SQL.Text;
    FLogger.LogInfo('SQL gerado com sucesso: ' + Result);
  except
    on E: Exception do
    begin
      LogarErro('Erro ao gerar SQL', E);
      raise ESQLGenerationException.Create('Erro ao gerar SQL', E);
    end;
  end;
end;

end.