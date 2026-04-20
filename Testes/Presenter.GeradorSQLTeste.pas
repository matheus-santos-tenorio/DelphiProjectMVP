unit Presenter.GeradorSQLTeste;

interface
uses
  DUnitX.TestFramework, Presenter.GeradorSQL, uLogger;

type

  [TestFixture]
  TPresenterGeradorSQLTeste = class(TObject)
  private
    FPresenter: IPresenterGeradorSQL;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure TestGerarSQLSucesso;
    [Test]
    procedure TestGerarSQLComColunasVazias;
    [Test]
    procedure TestGerarSQLComTabelaVazia;
  end;

implementation

uses
  System.SysUtils, uConstantes, uExceptions;

procedure TPresenterGeradorSQLTeste.Setup;
begin
  FPresenter := TPresenterGeradorSQL.Create;
end;

procedure TPresenterGeradorSQLTeste.TearDown;
begin
  FPresenter := nil;
end;

procedure TPresenterGeradorSQLTeste.TestGerarSQLSucesso;
var
  Resultado: string;
begin
  Resultado := FPresenter.GerarSQL('NOME,IDADE', 'PESSOA', 'IDADE > 18');
  Assert.IsNotEmpty(Resultado, 'SQL deve ser gerado');
  Assert.IsTrue(Resultado.Contains('SELECT'), 'SQL deve conter SELECT');
  Assert.IsTrue(Resultado.Contains('NOME'), 'SQL deve conter colunas');
  Assert.IsTrue(Resultado.Contains('PESSOA'), 'SQL deve conter tabela');
end;

procedure TPresenterGeradorSQLTeste.TestGerarSQLComColunasVazias;
begin
  Assert.WillRaise(
    procedure
    begin
      FPresenter.GerarSQL(STRING_VAZIA, 'PESSOA', STRING_VAZIA);
    end,
    ESQLGenerationException, 'Deve lançar exceção quando colunas vazias'
  );
end;

procedure TPresenterGeradorSQLTeste.TestGerarSQLComTabelaVazia;
begin
  Assert.WillRaise(
    procedure
    begin
      FPresenter.GerarSQL('NOME', STRING_VAZIA, STRING_VAZIA);
    end,
    ESQLGenerationException, 'Deve lançar exceção quando tabela vazia'
  );
end;

end.