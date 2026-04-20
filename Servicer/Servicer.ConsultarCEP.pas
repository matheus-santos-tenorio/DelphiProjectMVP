unit Servicer.ConsultarCEP;

interface

uses
  System.SysUtils, System.JSON, REST.Client, REST.Types;

type
  IServiceConsultarCEP = interface ['{343141F3-CB74-4B3C-A546-3DE9E8381D8A}']
  end;

  TServiceConsultarCEP = class(TInterfacedObject, IServiceConsultarCEP)
  public
    class function Buscar(const psCEP: string): string;
  end;

implementation

uses
  uConstantes;

class function TServiceConsultarCEP.Buscar(const psCEP: string): string;
var
  RESTClient: TRESTClient;
  RESTRequest: TRESTRequest;
  RESTResponse: TRESTResponse;
begin
  Result := STRING_VAZIA;

  RESTClient := TRESTClient.Create('https://viacep.com.br/ws/');
  RESTRequest := TRESTRequest.Create(nil);
  RESTResponse := TRESTResponse.Create(nil);

  try
    RESTRequest.Client := RESTClient;
    RESTRequest.Response := RESTResponse;
    RESTRequest.Method := rmGET;
    RESTRequest.Resource := psCEP + '/json/';

    RESTRequest.Execute;

    Result := RESTResponse.Content;
  finally
    RESTResponse.Free;
    RESTRequest.Free;
    RESTClient.Free;
  end;
end;

end.
