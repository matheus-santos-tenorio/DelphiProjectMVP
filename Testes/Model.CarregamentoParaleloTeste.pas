unit Model.CarregamentoParaleloTeste;

interface
uses
  DUnitX.TestFramework, Model.CarregamentoParalelo, Vcl.ComCtrls;

type

  [TestFixture]
  TCarregamentoParaleloTeste = class(TObject)
  private
    FCarregamentoParalelo: ICarregamentoParalelo;
    FProgressBar: TProgressBar;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure TestStartComValorValido;
    [Test]
    procedure TestStartComValorZero;
    [Test]
    procedure TestStartDuplicado;
    [Test]
    procedure TestStop;
    [Test]
    procedure TestGetStatusInicial;
  end;

implementation

uses
  System.SysUtils, uConstantes;

procedure TCarregamentoParaleloTeste.Setup;
begin
  FCarregamentoParalelo := TCarregamentoParalelo.Criar;
  FProgressBar := TProgressBar.Create(Nil);
  FProgressBar.Position := PROGRESS_BAR_POSICAO_INICIAL;
end;

procedure TCarregamentoParaleloTeste.TearDown;
begin
  FCarregamentoParalelo.Stop;
  FCarregamentoParalelo := nil;
  if Assigned(FProgressBar) then
    FreeAndNil(FProgressBar);
end;

procedure TCarregamentoParaleloTeste.TestStartComValorValido;
begin
  FCarregamentoParalelo.Start(100, FProgressBar);
  Assert.IsTrue(FCarregamentoParalelo.Status = dsIniciado, 'Status deve ser Iniciado');
end;

procedure TCarregamentoParaleloTeste.TestStartComValorZero;
begin
  Assert.WillRaise(
    procedure
    begin
      FCarregamentoParalelo.Start(PROGRESS_BAR_POSICAO_INICIAL, FProgressBar);
    end,
    Exception, 'Deve lançar exceção com valor zero'
  );
end;

procedure TCarregamentoParaleloTeste.TestStartDuplicado;
begin
  FCarregamentoParalelo.Start(100, FProgressBar);
  Assert.WillRaise(
    procedure
    begin
      FCarregamentoParalelo.Start(100, FProgressBar);
    end,
    Exception, 'Deve lançar exceção ao iniciar novamente'
  );
end;

procedure TCarregamentoParaleloTeste.TestStop;
begin
  FCarregamentoParalelo.Start(100, FProgressBar);
  FCarregamentoParalelo.Stop;
  Assert.IsTrue(FCarregamentoParalelo.Status = dsInterrompido, 'Status deve ser Interrompido');
end;

procedure TCarregamentoParaleloTeste.TestGetStatusInicial;
begin
  Assert.IsTrue(FCarregamentoParalelo.Status = dsParado, 'Status inicial deve ser Parado');
end;

initialization
  TDUnitX.RegisterTestFixture(TCarregamentoParaleloTeste);
end.
