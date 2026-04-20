unit Presenter.SimulacaoApi;

interface

uses
  System.SysUtils, System.Classes, uspQuery, Presenter.Base, uExceptions, uLogger,
  Model.ConsultarCEP, REST.Json, REST.Json.Types;

type
  IPresenterSimulacaoApi = interface
    ['{9EE202CF-AA53-4F2C-A413-4800D491F817}']
    function BuscarEndereco(psCEP: string): string;
  end;

  TPresenterSimulacaoApi = class(TBasePresenter, IPresenterSimulacaoApi)
  private
    FspQuery: TspQuery;
  public
    function BuscarEndereco(psCEP: string): string;
  end;

implementation

uses
  Servicer.ConsultarCEP;

{ TPresenterSimulacaoApi }

function TPresenterSimulacaoApi.BuscarEndereco(psCEP: string): string;
var
  ConsultarCEP: IConsultarCEP;
begin
  FLogger.LogInfo('Realizando consumo da API');
  try
    ConsultarCEP := TJson.JsonToObject<TConsultarCEP>(TServiceConsultarCEP.Buscar(psCEP));
    result := ConsultarCEP.FormatarTexto;

    FLogger.LogInfo('Consumo realizado com sucesso');
  except
    on E: Exception do
    begin
      LogarErro('Erro ao consumir a API', E);
      raise EProjetosTotalDivisoesException.Create('Erro ao consumir a API', E);
    end;
  end;
end;

end.
