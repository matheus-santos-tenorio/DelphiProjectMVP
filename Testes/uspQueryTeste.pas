unit uspQueryTeste;

interface
uses
  DUnitX.TestFramework, uspQuery;

type

  [TestFixture]
  TuspQueryTeste = class(TObject)
    FspQuery: TspQuery;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    // Sample Methods
    [Test]
    procedure Test_GerarSQL_DeveGerar_SQLValido;
    [Test]
    procedure Test_GerarSQL_DeveGerar_SQLQuandoCondicoesSaoVazias;

    [Test]
    procedure Test_GerarSQL_DeveFalhar_QuandoTabelaInvalida;
    [Test]
    procedure Test_GerarSQL_DeveFalhar_QuandoColunasVazias;
    [Test]
    procedure Test_GerarSQL_DeveFalhar_QuandoColunasApenasWhitespace;
  end;

implementation

uses
  System.SysUtils, uConstantes;

procedure TuspQueryTeste.Setup;
begin
  FspQuery := TspQuery.Create(Nil);
end;

procedure TuspQueryTeste.TearDown;
begin
  FreeAndNil(FspQuery);
end;

procedure TuspQueryTeste.Test_GerarSQL_DeveGerar_SQLValido;
begin
  FspQuery.GeraSQL('NOME' + #13#10 + 'IDADE' + #13#10 + 'CPF', 'PESSOA', 'IDADE > 18');

  Assert.IsTrue(FspQuery.SQL.Text.Contains('SELECT NOME, IDADE, CPF'), 'SQL nao contem a clausula SELECT esperada.');
  Assert.IsTrue(FspQuery.SQL.Text.Contains('FROM PESSOA'), 'SQL nao contem a clausula FROM esperada.');
  Assert.IsTrue(FspQuery.SQL.Text.Contains('WHERE IDADE > 18'), 'SQL nao contem a clausula WHERE esperada.');
end;

procedure TuspQueryTeste.Test_GerarSQL_DeveFalhar_QuandoTabelaInvalida;
begin
  try
    FspQuery.GeraSQL('NOME', 'T1' + #13#10 + 'T2', '1=1');
    Assert.Fail('Esperava EArgumentException quando mais de uma tabela e informada.');
  except
    on E: EArgumentException do
      ; // ok
    on E: Exception do
      Assert.Fail('Esperava EArgumentException, mas ocorreu ' + E.ClassName + ': ' + E.Message);
  end;
end;

procedure TuspQueryTeste.Test_GerarSQL_DeveFalhar_QuandoColunasVazias;
begin
  try
    FspQuery.GeraSQL(STRING_VAZIA, 'PESSOA', '1=1');
    Assert.Fail('Esperava EArgumentException quando as colunas estao vazias.');
  except
    on E: EArgumentException do
      ; // ok
    on E: Exception do
      Assert.Fail('Esperava EArgumentException, mas ocorreu ' + E.ClassName + ': ' + E.Message);
  end;
end;

procedure TuspQueryTeste.Test_GerarSQL_DeveGerar_SQLQuandoCondicoesSaoVazias;
begin
  FspQuery.GeraSQL('NOME' + #13#10 + 'IDADE', 'PESSOA', STRING_VAZIA);

  Assert.IsTrue(FspQuery.SQL.Text.Contains('SELECT NOME, IDADE'), 'SQL nao contem a clausula SELECT esperada.');
  Assert.IsTrue(FspQuery.SQL.Text.Contains('FROM PESSOA'), 'SQL nao contem a clausula FROM esperada.');
  Assert.IsTrue(not FspQuery.SQL.Text.Contains('WHERE '), 'SQL deveria nao conter WHERE quando condicoes estao vazias.');
end;

procedure TuspQueryTeste.Test_GerarSQL_DeveFalhar_QuandoColunasApenasWhitespace;
begin
  try
    FspQuery.GeraSQL('   ', 'PESSOA', '1=1');
    Assert.Fail('Esperava EArgumentException quando as colunas sao apenas whitespace.');
  except
    on E: EArgumentException do
      ; // ok
    on E: Exception do
      Assert.Fail('Esperava EArgumentException, mas ocorreu ' + E.ClassName + ': ' + E.Message);
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TuspQueryTeste);
end.
