unit ufProjetosTotalDivisoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Model.ProjetosTotalDivisoes, Presenter.ProjetosTotalDivisoes, uLogger,
  uConstantes;

type
  TfProjetosTotalDivisoes = class(TForm)
    lblValProjeto: TLabel;
    lblTotal: TLabel;
    lblTotalDivisoes: TLabel;
    btnObtTotal: TButton;
    btnObtTotDivisoes: TButton;
    edtTotal: TEdit;
    edtTotDivisoes: TEdit;
    dbgValProjeto: TDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnObtTotalClick(Sender: TObject);
    procedure btnObtTotDivisoesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fpProjetos: IPresenterProjetosTotalDivisoes;
  public
    { Public declarations }
  end;

var
  fProjetosTotalDivisoes: TfProjetosTotalDivisoes;

implementation

{$R *.dfm}

procedure TfProjetosTotalDivisoes.btnObtTotalClick(Sender: TObject);
begin
  try
    edtTotal.Text := fpProjetos.CalcularTotal;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TfProjetosTotalDivisoes.btnObtTotDivisoesClick(Sender: TObject);
begin
  try
    edtTotDivisoes.Text := fpProjetos.CalcularDivisoes;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TfProjetosTotalDivisoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fpProjetos := nil;
  FreeAndNil(fProjetosTotalDivisoes);
end;

procedure TfProjetosTotalDivisoes.FormCreate(Sender: TObject);
var
  dsConfig: TDataSource;
begin
  fpProjetos := TPresenterProjetosTotalDivisoes.Create;
  try
    fpProjetos.ConfigurarDataSource(dsConfig);
    dbgValProjeto.DataSource := dsConfig;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;

  // Estado inicial do form.
  edtTotal.Text := STRING_VAZIA;
  edtTotDivisoes.Text := STRING_VAZIA;
end;

end.
