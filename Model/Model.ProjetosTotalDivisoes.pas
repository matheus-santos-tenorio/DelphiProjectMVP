unit Model.ProjetosTotalDivisoes;

interface

uses
  Datasnap.DBClient, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, uConstantes;

type
  IProjetosTotalDivisoes = interface
    ['{AF1FF272-CF3B-4D65-B70E-43928624A895}']

    function Totalizador: Double;
    function Divisor: Double;
    function GetDataSource: TDataSource;

  end;

  TProjetosTotalDivisoes = class(TInterfacedObject, IProjetosTotalDivisoes)
    private
      FClientDataSet: TClientDataSet;
      FDataSource: TDataSource;

    public
      constructor Create;
      destructor Destroy; Override;

      class function Criar: IProjetosTotalDivisoes;
      function Totalizador: Double;
      function Divisor: Double;
      function GetDataSource: TDataSource;
  end;

implementation

{ TProjetosTotalDivisoes }

constructor TProjetosTotalDivisoes.Create;
var
  Codigo, I: Integer;
begin
  Randomize;
  FClientDataSet := TClientDataSet.Create(nil);
  FDataSource    := TDataSource.Create(nil);

  FClientDataSet.FieldDefs.Add('IdProjeto', ftInteger);
  FClientDataSet.FieldDefs.Add('NomeProjeto', ftString, 12);
  FClientDataSet.FieldDefs.Add('Valor', ftFloat);

  FClientDataSet.CreateDataSet;

  for I := 1 to 10 do
  begin
    repeat
      Codigo := Random(RANDOM_MAX);
    until (not (FClientDataSet.Locate('IdProjeto', Codigo, []))) and (Codigo <> NUMERO_ZERO) ;

    FClientDataSet.Append;
    FClientDataSet.FieldByName('IdProjeto').AsInteger := Codigo;
    FClientDataSet.FieldByName('NomeProjeto').AsString := 'Projeto ' + IntToStr(Codigo);
    FClientDataSet.FieldByName('Valor').AsFloat := Random(RANDOM_MAX);
    TNumericField(FClientDataSet.FieldByName('Valor')).DisplayFormat := 'R$###,###,##0.00';
    FClientDataSet.Post;
  end;

  FDataSource.DataSet := FClientDataSet;
end;

class function TProjetosTotalDivisoes.Criar: IProjetosTotalDivisoes;
begin
  Result := TProjetosTotalDivisoes.Create;
end;

destructor TProjetosTotalDivisoes.Destroy;
begin
  FreeAndNil(FClientDataSet);
  FreeAndNil(FDataSource);
  inherited;
end;

function TProjetosTotalDivisoes.Divisor: Double;
var
  Divisor: Double;
begin
  try
    FClientDataSet.First;
    Result := NUMERO_ZERO;
    Divisor := NUMERO_ZERO;
    while not FClientDataSet.Eof do
    begin
      if FClientDataSet.RecNo = 1 then
        Divisor := FClientDataSet.FieldByName('Valor').AsFloat
      else
      begin
        if Divisor = NUMERO_ZERO then
          raise Exception.Create('Divisor zero detectado: não é possível dividir por zero');

        Result := Result + (FClientDataSet.FieldByName('Valor').AsFloat / Divisor);
        Divisor := FClientDataSet.FieldByName('Valor').AsFloat;
      end;

      FClientDataSet.Next;
    end;
  except
    on E: Exception do
      raise Exception.Create(E.ClassName + ' erro ao calcular a divisão. ' + #13#10 + E.Message);
  end;
end;

function TProjetosTotalDivisoes.GetDataSource: TDataSource;
begin
  Result := FDataSource;
end;

function TProjetosTotalDivisoes.Totalizador: Double;
begin
  try
    FClientDataSet.First;
    Result := NUMERO_ZERO;
    while not FClientDataSet.Eof do
    begin
      Result := Result + FClientDataSet.FieldByName('Valor').AsFloat;
      FClientDataSet.Next;
    end;
  except
    on E: Exception do
      raise Exception.Create(E.ClassName + ' erro ao calcular o somatorio. ' + #13#10 + E.Message);
  end;
end;

end.
