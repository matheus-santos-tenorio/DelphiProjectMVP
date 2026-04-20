unit Model.ProjetosTotalDivisoesTeste;

interface
uses
  DUnitX.TestFramework, Model.ProjetosTotalDivisoes;

type

  [TestFixture]
  TProjetosTotalDivisoesTeste = class(TObject)
  private
    FProjetosTotalDivisoes: IProjetosTotalDivisoes;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    // Sample Methods
    // Simple single Test
    [Test]
    procedure Test1;
    procedure Test2;
  end;

implementation

procedure TProjetosTotalDivisoesTeste.Setup;
begin
  FProjetosTotalDivisoes := TProjetosTotalDivisoes.Criar;
end;

procedure TProjetosTotalDivisoesTeste.TearDown;
begin

end;

procedure TProjetosTotalDivisoesTeste.Test1;
var
  Resultado: Double;
begin
  Resultado := FProjetosTotalDivisoes.Totalizador;

  Assert.IsTrue(Resultado > NUMERO_ZERO, 'Ocorreu um erro ao tentar totalizar os valores do CDS');
end;

procedure TProjetosTotalDivisoesTeste.Test2;
var
  Resultado: Double;
begin
  Resultado := FProjetosTotalDivisoes.Divisor;

  Assert.IsTrue(Resultado > NUMERO_ZERO, 'Ocorreu um erro ao tentar dividir os valores do CDS');
end;

initialization
  TDUnitX.RegisterTestFixture(TProjetosTotalDivisoesTeste);
end.
