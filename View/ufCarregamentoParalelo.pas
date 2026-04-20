unit ufCarregamentoParalelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Model.CarregamentoParalelo, Presenter.CarregamentoParalelo,
  uLogger, uConstantes;

type
  TfCarregamentoParalelo = class(TForm)
    pbPriThread: TProgressBar;
    pbSegThread: TProgressBar;
    edtPriThread: TEdit;
    edtSegThread: TEdit;
    lblPriThread: TLabel;
    lblSegThread: TLabel;
    btnIniciarCarregamento: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnIniciarCarregamentoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fpCarregamento: IPresenterCarregamentoParalelo;
  public
    { Public declarations }
  end;

var
  fCarregamentoParalelo: TfCarregamentoParalelo;

implementation

{$R *.dfm}

procedure TfCarregamentoParalelo.btnIniciarCarregamentoClick(Sender: TObject);
var
  nPriValor, nSegValor: Integer;
begin
  nPriValor := StrToIntDef(edtPriThread.Text, NUMERO_ZERO);
  nSegValor := StrToIntDef(edtSegThread.Text, NUMERO_ZERO);

  if (nPriValor <= NUMERO_ZERO) or (nSegValor <= NUMERO_ZERO) then
  begin
    ShowMessage('Informe valores superiores a 0 para ambos os campos.');
    Exit;
  end;

  try
    fpCarregamento.IniciarCarregamento(nPriValor, nSegValor, pbPriThread, pbSegThread);
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TfCarregamentoParalelo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  try
    fpCarregamento.PararCarregamento;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
  fpCarregamento := nil;
  FreeAndNil(fCarregamentoParalelo);
end;

procedure TfCarregamentoParalelo.FormCreate(Sender: TObject);
begin
  fpCarregamento := TPresenterCarregamentoParalelo.Create;

  // Valores iniciais para facilitar entendimento.
  edtPriThread.Text := '50';
  edtSegThread.Text := '80';
  pbPriThread.Position := PROGRESS_BAR_POSICAO_INICIAL;
  pbSegThread.Position := PROGRESS_BAR_POSICAO_INICIAL;
end;

end.
