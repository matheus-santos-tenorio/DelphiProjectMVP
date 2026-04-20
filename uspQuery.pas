unit uspQuery;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Classes, System.SysUtils, FireDAC.Phys.MySQLDef,
  FireDAC.Phys, FireDAC.Phys.MySQL, uConstantes;

type
  TspQuery = class(TFDQuery)

  private
    FspCondicoes: TStringList;
    FspColunas: TStringList;
    FspTabelas: TStringList;

    function FormatarTextoParaLinhas(const psTexto: String): TArray<string>;
    procedure ProcessarTextoLinhas(const psTexto: String; pstList: TStringList);
  public

    property spCondicoes: TStringList read FspCondicoes;
    property spColunas: TStringList read FspColunas;
    property spTabelas: TStringList read FspTabelas;

    procedure GeraSQL(psColunas, psTabelas, psCondicoes: String);

    constructor Create(AOwner: TComponent); Override;
    destructor Destroy; Override;

  end;

implementation

{ TspQuery }

constructor TspQuery.Create(AOwner: TComponent);
begin
  inherited;

  FspCondicoes := TStringList.Create;
  FspColunas   := TStringList.Create;
  FspTabelas   := TStringList.Create;
end;

destructor TspQuery.Destroy;
begin
  FreeAndNil(FspCondicoes);
  FreeAndNil(FspColunas);
  FreeAndNil(FspTabelas);
  inherited;
end;

function TspQuery.FormatarTextoParaLinhas(const psTexto: String): TArray<string>;
var
  sTexto: String;
begin
  if Trim(psTexto) = STRING_VAZIA then
  begin
    SetLength(Result, NUMERO_ZERO);
    Exit;
  end;

  // Normaliza finais de linha (CRLF e CR) para LF para ent?o fazer o split.
  sTexto := psTexto;
  sTexto := StringReplace(sTexto, #13#10, #10, [rfReplaceAll]);
  sTexto := StringReplace(sTexto, #13, #10, [rfReplaceAll]);
  Result := sTexto.Split([#10], TStringSplitOptions.ExcludeEmpty);
end;

procedure TspQuery.ProcessarTextoLinhas(const psTexto: String; pstList: TStringList);
var
  LinhasFormatadas: TArray<string>;
  sLinha, sLinhaTrim: String;
begin
  pstList.BeginUpdate;
  try
    pstList.Clear;

    // cada item deve estar em uma linha.
    LinhasFormatadas := FormatarTextoParaLinhas(psTexto);
    for sLinha in LinhasFormatadas do
    begin
      sLinhaTrim := Trim(sLinha);
      if sLinhaTrim <> STRING_VAZIA then
        pstList.Add(sLinhaTrim);
    end;
  finally
    pstList.EndUpdate;
  end;
end;

procedure TspQuery.GeraSQL(psColunas, psTabelas, psCondicoes: String);
var
  sColuna, sColunas: string;
begin
  ProcessarTextoLinhas(psColunas, FspColunas);
  ProcessarTextoLinhas(psTabelas, FspTabelas);
  FspCondicoes.Text := psCondicoes;

  if (Trim(psColunas) = STRING_VAZIA) or (FspColunas.Count = NUMERO_ZERO) then
    raise EArgumentException.Create('Informe uma ou mais colunas (por linha).');

  if (Trim(psTabelas) = STRING_VAZIA) or (FspTabelas.Count = NUMERO_ZERO) then
    raise EArgumentException.Create('Informe a tabela (apenas 1).');

  if FspTabelas.Count <> 1 then
    raise EArgumentException.Create('So e possivel informar uma unica tabela.');

  SQL.Text := STRING_VAZIA;
  sColunas := STRING_VAZIA;
  for sColuna in FspColunas do
  begin
    if sColunas <> STRING_VAZIA then
      sColunas := sColunas + ', ';
    sColunas := sColunas + Trim(sColuna);
  end;

  SQL.Add('SELECT ' + Trim(sColunas));
  SQL.Add('FROM ' + Trim(FspTabelas[NUMERO_ZERO]));

  if Trim(psCondicoes) <> STRING_VAZIA then
    SQL.Add('WHERE ' + Trim(psCondicoes));
end;

end.
