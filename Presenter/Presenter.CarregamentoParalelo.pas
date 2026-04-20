unit Presenter.CarregamentoParalelo;

interface

uses
  System.SysUtils, System.Classes, Vcl.ComCtrls, Model.CarregamentoParalelo, Presenter.Base, uExceptions,
  uLogger;

type
  IPresenterCarregamentoParalelo = interface['{A96EEB9C-C01B-488C-8577-13616AB6D0F7}']
    procedure IniciarCarregamento(pnValor1, pnValor2: Integer; ppbProgressBar1, ppbProgressBar2: TProgressBar);
    procedure PararCarregamento;
  end;

  TPresenterCarregamentoParalelo = class(TBasePresenter, IPresenterCarregamentoParalelo)
  private
    FThread1, FThread2: ICarregamentoParalelo;
  public
    constructor Create;
    destructor Destroy; override;

    procedure IniciarCarregamento(pnValor1, pnValor2: Integer; ppbProgressBar1, ppbProgressBar2: TProgressBar);
    procedure PararCarregamento;
  end;

implementation

{ TPresenterCarregamentoParalelo }

constructor TPresenterCarregamentoParalelo.Create;
begin
  inherited;
  FThread1 := TCarregamentoParalelo.Criar;
  FThread2 := TCarregamentoParalelo.Criar;
end;

destructor TPresenterCarregamentoParalelo.Destroy;
begin
  PararCarregamento;
  inherited;
end;

procedure TPresenterCarregamentoParalelo.IniciarCarregamento(pnValor1, pnValor2: Integer; ppbProgressBar1, ppbProgressBar2: TProgressBar);
begin
  FLogger.LogInfo('Iniciando carregamento paralelo com valores: ' + IntToStr(pnValor1) + ', ' + IntToStr(pnValor2));
  try
    FThread1.Start(pnValor1, ppbProgressBar1);
    FThread2.Start(pnValor2, ppbProgressBar2);
    FLogger.LogInfo('Carregamento paralelo iniciado com sucesso');
  except
    on E: Exception do
    begin
      LogarErro('Erro ao iniciar carregamento paralelo', E);
      raise ECarregamentoParaleloException.Create('Erro ao iniciar carregamento paralelo', E);
    end;
  end;
end;

procedure TPresenterCarregamentoParalelo.PararCarregamento;
begin
  FLogger.LogInfo('Parando carregamento paralelo');
  try
    if Assigned(FThread1) then
      FThread1.Stop;
    if Assigned(FThread2) then
      FThread2.Stop;
    FLogger.LogInfo('Carregamento paralelo parado com sucesso');
  except
    on E: Exception do
    begin
      LogarErro('Erro ao parar carregamento paralelo', E);
      raise ECarregamentoParaleloException.Create('Erro ao parar carregamento paralelo', E);
    end;
  end;
end;

end.