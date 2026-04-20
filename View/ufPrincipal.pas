unit ufPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uspQuery, uLogger;

type
  TfPrincipal = class(TForm)
    mmFuncionalidades: TMainMenu;
    miFuncionalidades: TMenuItem;
    miGeradorSQL: TMenuItem;
    miCarregamentoParalelo: TMenuItem;
    miProjetosTotalDivisoes: TMenuItem;
    miSimulaoAPI: TMenuItem;
    procedure miGeradorSQLClick(Sender: TObject);
    procedure miCarregamentoParaleloClick(Sender: TObject);
    procedure miProjetosTotalDivisoesClick(Sender: TObject);
    procedure miSimulaoAPIClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fPrincipal: TfPrincipal;  

implementation

{$R *.dfm}

uses ufGeradorSQL, ufCarregamentoParalelo, ufProjetosTotalDivisoes, ufSimulacaoApi;

procedure TfPrincipal.miGeradorSQLClick(Sender: TObject);
begin
  if not Assigned(fGeradorSQL) then
    fGeradorSQL := TfGeradorSQL.Create(Self);

  fGeradorSQL.Show;
end;

procedure TfPrincipal.miCarregamentoParaleloClick(Sender: TObject);
begin
  if not Assigned(fCarregamentoParalelo) then
    fCarregamentoParalelo := TfCarregamentoParalelo.Create(Self);

  fCarregamentoParalelo.Show;
end;

procedure TfPrincipal.miProjetosTotalDivisoesClick(Sender: TObject);
begin
  if not Assigned(fProjetosTotalDivisoes) then
    fProjetosTotalDivisoes := TfProjetosTotalDivisoes.Create(Self);

  fProjetosTotalDivisoes.Show;
end;

procedure TfPrincipal.miSimulaoAPIClick(Sender: TObject);
begin
  if not Assigned(fSimulacaoAPI) then
    fSimulacaoAPI := TfSimulacaoAPI.Create(Self);

  fSimulacaoAPI.Show;
end;


end.
