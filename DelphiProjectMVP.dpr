program DelphiProjectMVP;

uses
  Vcl.Forms,
  ufPrincipal in 'View\ufPrincipal.pas' {fPrincipal},
  ufGeradorSQL in 'View\ufGeradorSQL.pas' {fGeradorSQL},
  ufCarregamentoParalelo in 'View\ufCarregamentoParalelo.pas' {fCarregamentoParalelo},
  Model.ProjetosTotalDivisoes in 'Model\Model.ProjetosTotalDivisoes.pas',
  Model.CarregamentoParalelo in 'Model\Model.CarregamentoParalelo.pas',
  ufProjetosTotalDivisoes in 'View\ufProjetosTotalDivisoes.pas' {fProjetosTotalDivisoes},
  Presenter.Base in 'Presenter\Presenter.Base.pas',
  Presenter.GeradorSQL in 'Presenter\Presenter.GeradorSQL.pas',
  Presenter.CarregamentoParalelo in 'Presenter\Presenter.CarregamentoParalelo.pas',
  Presenter.ProjetosTotalDivisoes in 'Presenter\Presenter.ProjetosTotalDivisoes.pas',
  uLogger in 'Utils\uLogger.pas',
  uExceptions in 'Utils\uExceptions.pas',
  uConstantes in 'Utils\uConstantes.pas',
  ufSimulacaoApi in 'View\ufSimulacaoApi.pas' {fSimulacaoApi},
  Servicer.ConsultarCEP in 'Servicer\Servicer.ConsultarCEP.pas',
  Presenter.SimulacaoApi in 'Presenter\Presenter.SimulacaoApi.pas',
  Model.ConsultarCEP in 'Model\Model.ConsultarCEP.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfPrincipal, fPrincipal);
  Application.Run;
end.
