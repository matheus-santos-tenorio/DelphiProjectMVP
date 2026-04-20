unit Model.ConsultarCEP;

interface

type
  IConsultarCEP = Interface
    ['{6AA313A2-AE57-4B3D-9FF6-F73EF1C94DDC}']

    function FormatarTexto: string;
  End;

  TConsultarCEP = class(TInterfacedObject, IConsultarCEP)
  private
    FCep: string;
    FLogradouro: string;
    FComplemento: string;
    FUnidade: string;
    FBairro: string;
    FLocalidade: string;
    FUf: string;
    FEstado: string;
    FRegiao: string;
    FIbge: string;
    FGia: string;
    FDdd: string;
    FSiafi: string;

  public
    function FormatarTexto: string;

    [JSONName('cep')]
    property Cep: string read FCep write FCep;
    [JSONName('logradouro')]
    property Logradouro: string read FLogradouro write FLogradouro;
    [JSONName('complemento')]
    property Complemento: string read FComplemento write FComplemento;
    [JSONName('unidade')]
    property Unidade: string read FUnidade write FUnidade;
    [JSONName('bairro')]
    property Bairro: string read FBairro write FBairro;
    [JSONName('localidade')]
    property Localidade: string read FLocalidade write FLocalidade;
    [JSONName('uf')]
    property Uf: string read FUf write FUf;
    [JSONName('estado')]
    property Estado: string read FEstado write FEstado;
    [JSONName('regiao')]
    property Regiao: string read FRegiao write FRegiao;
    [JSONName('ibge')]
    property Ibge: string read FIbge write FIbge;
    [JSONName('gia')]
    property Gia: string read FGia write FGia;
    [JSONName('ddd')]
    property Ddd: string read FDdd write FDdd;
    [JSONName('siafi')]
    property Siafi: string read FSiafi write FSiafi;
  end;

implementation

{ TConsultarCEP }

function TConsultarCEP.FormatarTexto: string;
begin
  Result := 'CEP: ' + Cep + sLineBreak +
            'Logradouro: ' + Logradouro + sLineBreak +
            'Complemento: ' + Complemento + sLineBreak +
            'Unidade: ' + Unidade + sLineBreak +
            'Bairro: ' + Bairro + sLineBreak +
            'Localidade: ' + Localidade + sLineBreak +
            'UF: ' + Uf + sLineBreak +
            'Estado: ' + Estado + sLineBreak +
            'Região: ' + Regiao + sLineBreak +
            'IBGE: ' + Ibge + sLineBreak +
            'GIA: ' + Gia + sLineBreak +
            'DDD: ' + Ddd + sLineBreak +
            'SIAFI: ' + Siafi;
end;

end.
