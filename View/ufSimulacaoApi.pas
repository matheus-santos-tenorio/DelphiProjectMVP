unit ufSimulacaoApi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Presenter.SimulacaoApi;

type
  TfSimulacaoApi = class(TForm)
    btnBuscaEnd: TButton;
    edtBuscarCep: TEdit;
    memEndereco: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnBuscaEndClick(Sender: TObject);
  private
    { Private declarations }
    fpSimulacaoApi: IPresenterSimulacaoApi;
  public
    { Public declarations }
  end;

var
  fSimulacaoApi: TfSimulacaoApi;

implementation

{$R *.dfm}

{ TfSimulacaoApi }

procedure TfSimulacaoApi.btnBuscaEndClick(Sender: TObject);
begin
  memEndereco.lines.text := fpSimulacaoApi.BuscarEndereco(edtBuscarCep.text);
end;

procedure TfSimulacaoApi.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fpSimulacaoApi := nil;
  FreeAndNil(fSimulacaoApi);
end;

procedure TfSimulacaoApi.FormCreate(Sender: TObject);
begin
  fpSimulacaoApi := TPresenterSimulacaoApi.Create;
  edtBuscarCep.text := '01001-000';
end;

end.
