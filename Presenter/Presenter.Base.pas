unit Presenter.Base;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, uLogger, uExceptions;

type
  /// <summary>
  /// Interface base para todos os presenters
  /// </summary>
  IBasePresenter = interface
    ['{A1B2C3D4-E5F6-7890-ABCD-EF1234567891}']
    /// <summary>Registra um erro no log</summary>
    procedure LogarErro(psMensagem: string; poException: Exception = nil);
  end;

  /// <summary>
  /// Classe base para presenters com funcionalidade de logging
  /// </summary>
  /// <remarks>
  /// Fornece método comum para tratamento de erros e logging.
  /// Todos os presenters devem herdar desta classe.
  /// </remarks>
  TBasePresenter = class(TInterfacedObject, IBasePresenter)
  protected
    /// <summary>Referência ao logger para registro de eventos</summary>
    FLogger: ILogger;
    /// <summary>Registra erro no log e opcionalmente lança exceção</summary>
    procedure LogarErro(psMensagem: string; poException: Exception = nil); virtual;
  public
    /// <summary>Cria o presenter com injeção de dependência do logger</summary>
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TBasePresenter }

constructor TBasePresenter.Create;
begin
  inherited Create;
  FLogger := TFileLogger.GetInstance;
end;

destructor TBasePresenter.Destroy;
begin
  inherited;
  FLogger := nil;
end;

procedure TBasePresenter.LogarErro(psMensagem: string; poException: Exception = nil);
var
  MensagemErro: string;
begin
  if Assigned(poException) then
    MensagemErro := psMensagem + ': ' + poException.Message
  else
    MensagemErro := psMensagem;

  if Assigned(FLogger) then
    FLogger.LogError(MensagemErro);
end;

end.