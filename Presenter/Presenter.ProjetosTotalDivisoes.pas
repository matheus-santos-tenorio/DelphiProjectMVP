unit Presenter.ProjetosTotalDivisoes;

interface

uses
  System.SysUtils, System.Classes, Vcl.StdCtrls, Model.ProjetosTotalDivisoes, Presenter.Base, uExceptions,
  Data.DB, uLogger;

type
  IPresenterProjetosTotalDivisoes = interface['{9B4A698C-5619-4C3A-891F-8082B5059392}']
    function CalcularTotal: string;
    function CalcularDivisoes: string;
    procedure ConfigurarDataSource(var pdsDataSource: TDataSource);
  end;

  TPresenterProjetosTotalDivisoes = class(TBasePresenter, IPresenterProjetosTotalDivisoes)
  private
    FProjeto: IProjetosTotalDivisoes;
  public
    constructor Create;
    destructor Destroy; override;

    function CalcularTotal: string;
    function CalcularDivisoes: string;
    procedure ConfigurarDataSource(var pdsDataSource: TDataSource);
  end;

implementation

{ TPresenterProjetosTotalDivisoes }

constructor TPresenterProjetosTotalDivisoes.Create;
begin
  inherited;
  FProjeto := TProjetosTotalDivisoes.Criar;
end;

destructor TPresenterProjetosTotalDivisoes.Destroy;
begin
  inherited;
end;

function TPresenterProjetosTotalDivisoes.CalcularTotal: string;
begin
  FLogger.LogInfo('Calculando total dos projetos');
  try
    Result := FormatFloat('R$, 0.00', FProjeto.Totalizador);
    FLogger.LogInfo('Total calculado: ' + Result);
  except
    on E: Exception do
    begin
      LogarErro('Erro ao calcular total', E);
      raise EProjetosTotalDivisoesException.Create('Erro ao calcular total', E);
    end;
  end;
end;

function TPresenterProjetosTotalDivisoes.CalcularDivisoes: string;
begin
  FLogger.LogInfo('Calculando divisoes dos projetos');
  try
    Result := FormatFloat('R$, 0.00', FProjeto.Divisor);
    FLogger.LogInfo('Divisoes calculadas: ' + Result);
  except
    on E: Exception do
    begin
      LogarErro('Erro ao calcular divisoes', E);
      raise EProjetosTotalDivisoesException.Create('Erro ao calcular divisoes', E);
    end;
  end;
end;

procedure TPresenterProjetosTotalDivisoes.ConfigurarDataSource(var pdsDataSource: TDataSource);
begin
  FLogger.LogInfo('Configurando DataSource para projetos');
  try
    pdsDataSource := FProjeto.GetDataSource;
    FLogger.LogInfo('DataSource configurado com sucesso');
  except
    on E: Exception do
    begin
      LogarErro('Erro ao configurar DataSource', E);
      raise EProjetosTotalDivisoesException.Create('Erro ao configurar DataSource', E);
    end;
  end;
end;

end.