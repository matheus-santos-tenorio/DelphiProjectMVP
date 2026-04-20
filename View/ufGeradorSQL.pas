unit ufGeradorSQL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uspQuery, FireDAC.Phys.MySQLDef,
  FireDAC.Phys, FireDAC.Phys.MySQL, Presenter.GeradorSQL;

type
  TfGeradorSQL = class(TForm)
    lblColunas: TLabel;
    lblTabelas: TLabel;
    lblCondicoes: TLabel;
    memColunas: TMemo;
    memTabelas: TMemo;
    memCondicoes: TMemo;
    memSQLGerado: TMemo;
    lblSqlGerado: TLabel;
    btnGeraSQL: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGeraSQLClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    fpGerador: IPresenterGeradorSQL;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fGeradorSQL: TfGeradorSQL;

implementation

{$R *.dfm}

procedure TfGeradorSQL.FormCreate(Sender: TObject);
begin
  fpGerador := TPresenterGeradorSQL.Create;
  // Exemplo para facilitar entendimento do uso.
  memColunas.Lines.Text := 'NOME' + #13#10 + 'IDADE' + #13#10 + 'CPF';
  memTabelas.Lines.Text := 'PESSOA';
  memCondicoes.Lines.Text := 'IDADE > 18';
  memSQLGerado.Text := 'Clique em "Gerar SQL" para visualizar o SELECT gerado.';
end;

procedure TfGeradorSQL.btnGeraSQLClick(Sender: TObject);
begin
  try
    memSQLGerado.Text := fpGerador.GerarSQL(memColunas.Lines.Text, memTabelas.Lines.Text, memCondicoes.Lines.Text);
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TfGeradorSQL.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fpGerador := nil;
  FreeAndNil(fGeradorSQL);
end;

procedure TfGeradorSQL.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (memColunas.Focused) or (memTabelas.Focused) then
  begin
    case Key of
      #32: Key := #0;
      ',': Key := #13;
    end;
  end;
end;

end.

