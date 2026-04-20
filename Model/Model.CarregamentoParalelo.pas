unit Model.CarregamentoParalelo;

interface

uses
  Vcl.ComCtrls, System.SyncObjs, System.Threading;

type
  /// <summary>
  /// Status possíveis do carregamento paralelo
  /// </summary>
  TStatus = (dsParado, dsIniciado, dsFinalizado, dsErro, dsInterrompido);

  /// <summary>
  /// Interface para controle de carregamento paralelo com duas threads
  /// </summary>
  ICarregamentoParalelo = Interface
    ['{DA81C305-75CC-475D-BDA2-5AED9470F437}']
    /// <summary>Inicia o carregamento paralelo com o valor especificado</summary>
    procedure Start(pnValor: Integer; ppbProgressBar: TProgressBar);
    /// <summary>Interrompe o carregamento em andamento</summary>
    procedure Stop;
    /// <summary>Executa a thread de carregamento internamente</summary>
    procedure ExecThread;
    /// <summary>Retorna o status atual do carregamento</summary>
    function GetStatus:TStatus;
    /// <summary>Propriedade somente leitura para o status</summary>
    property Status: TStatus read GetStatus;
  End;

  /// <summary>
  /// Implementação de carregamento paralelo com proteção thread-safe
  /// </summary>
  /// <remarks>Usa TCriticalSection para proteger acesso concorrente ao status</remarks>
  TCarregamentoParalelo = class (TInterfacedObject, ICarregamentoParalelo)
  private
    FStatus: TStatus;
    FErro: String;
    FValor: Integer;
    FProgressBar: TProgressBar;
    FTask: ITask;
    FCriticalSection: TCriticalSection;
  public
    /// <summary>Cria uma nova instância do carregamento paralelo</summary>
    constructor Create;
    /// <summary>Destrói a instância e limpa recursos</summary>
    destructor Destroy; Override;

    /// <summary>Método factory para criação da interface</summary>
    class function Criar: ICarregamentoParalelo;

    /// <summary>Inicia o carregamento com o valor e progressbar especificados</summary>
    procedure Start(pnValor: Integer; ppbProgressBar: TProgressBar);
    /// <summary>Interrompe o carregamento em andamento</summary>
    procedure Stop;
    /// <summary>Executa a thread de carregamento</summary>
    procedure ExecThread;
    /// <summary>Retorna o status atual do carregamento</summary>
    function GetStatus:TStatus;
    /// <summary>Propriedade somente leitura para o status</summary>
    property Status: TStatus read GetStatus;
  end;

implementation

uses
  System.SysUtils, System.Classes, uConstantes;

{ TCarregamentoParalelo }

constructor TCarregamentoParalelo.Create;
begin
  FStatus := dsParado;
  FCriticalSection := TCriticalSection.Create;
end;

class function TCarregamentoParalelo.Criar: ICarregamentoParalelo;
begin
  Result := TCarregamentoParalelo.Create;
end;

destructor TCarregamentoParalelo.Destroy;
begin
  if Assigned(FTask) then
  begin
    FTask.Cancel;
    FTask := nil;
  end;
  FCriticalSection.Free;
  inherited;
end;

procedure TCarregamentoParalelo.ExecThread;
begin
  FTask := TTask.Create(
    procedure
    begin
      try
        while FProgressBar.Position < PROGRESS_BAR_MAX do
        begin
          FCriticalSection.Enter;
          try
            if FStatus = dsIniciado then
            begin
              FCriticalSection.Leave;
              Sleep(FValor);

              TThread.Synchronize(nil, procedure
              begin
                FProgressBar.Position := FProgressBar.Position + 1
              end);
            end
            else
            begin
              FCriticalSection.Leave;
              Break;
            end;
          except
            FCriticalSection.Leave;
            raise;
          end;
        end;

        FCriticalSection.Enter;
        try
          FStatus := dsFinalizado;
        finally
          FCriticalSection.Leave;
        end;
      except
        on E: Exception do
        begin
          FCriticalSection.Enter;
          try
            FStatus := dsErro;
          finally
            FCriticalSection.Leave;
          end;
          raise Exception.Create(E.Message);
        end;
      end;
    end);

  FTask.Start;
end;

function TCarregamentoParalelo.GetStatus: TStatus;
begin
  FCriticalSection.Enter;
  try
    Result := FStatus;
  finally
    FCriticalSection.Leave;
  end;
end;

procedure TCarregamentoParalelo.Start(pnValor: Integer; ppbProgressBar: TProgressBar);
begin
  if pnValor = NUMERO_ZERO then
    raise Exception.Create(MSG_VALOR_MINIMO_INVALIDO);

  FCriticalSection.Enter;
  try
    if FStatus = dsIniciado then
      raise Exception.Create(MSG_THREAD_INICIADA);
  finally
    FCriticalSection.Leave;
  end;

  FValor := pnValor;
  FProgressBar := ppbProgressBar;
  FProgressBar.Position := PROGRESS_BAR_POSICAO_INICIAL;

  FCriticalSection.Enter;
  try
    FStatus := dsIniciado;
  finally
    FCriticalSection.Leave;
  end;

  ExecThread;
end;

procedure TCarregamentoParalelo.Stop;
begin
  FCriticalSection.Enter;
  try
    FStatus := dsInterrompido;
  finally
    FCriticalSection.Leave;
  end;
end;

end.
