unit LoggerTeste;

interface
uses
  DUnitX.TestFramework, Utils.Logger;

type

  [TestFixture]
  TLoggerTeste = class(TObject)
  private
    FLogger: ILogger;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure TestLogInfo;
    [Test]
    procedure TestLogError;
  end;

implementation

uses
  System.SysUtils, System.IOUtils;

procedure TLoggerTeste.Setup;
begin
  FLogger := TFileLogger.Create;
end;

procedure TLoggerTeste.TearDown;
var
  LogDir: string;
begin
  FLogger := nil;
  LogDir := TDirectory.GetCurrentDirectory + '\Logger';
  if TDirectory.Exists(LogDir) then
    TDirectory.Delete(LogDir, True);
end;

procedure TLoggerTeste.TestLogInfo;
var
  LogFiles: TArray<string>;
  LogDir: string;
begin
  FLogger.LogInfo('Teste de log info');
  LogDir := TDirectory.GetCurrentDirectory + '\Logger';
  if TDirectory.Exists(LogDir) then
  begin
    LogFiles := TDirectory.GetFiles(LogDir, '*.log');
    Assert.IsTrue(Length(LogFiles) > NUMERO_ZERO, 'Arquivo de log deve existir');
    Assert.IsTrue(TFile.ReadAllText(LogFiles[NUMERO_ZERO]).Contains('Teste de log info'), 'Log deve conter a mensagem');
  end
  else
    Assert.Fail('Pasta Logger não foi criada');
end;

procedure TLoggerTeste.TestLogError;
var
  LogFiles: TArray<string>;
  LogDir: string;
begin
  FLogger.LogError('Teste de log error');
  LogDir := TDirectory.GetCurrentDirectory + '\Logger';
  if TDirectory.Exists(LogDir) then
  begin
    LogFiles := TDirectory.GetFiles(LogDir, '*.log');
    Assert.IsTrue(Length(LogFiles) > NUMERO_ZERO, 'Arquivo de log deve existir');
    Assert.IsTrue(TFile.ReadAllText(LogFiles[NUMERO_ZERO]).Contains('Teste de log error'), 'Log deve conter a mensagem de erro');
  end
  else
    Assert.Fail('Pasta Logger não foi criada');
end;

end.