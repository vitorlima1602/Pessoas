unit uTelaHeranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, uDTMConexao;

type
  TfrmTelaHeranca = class(TForm)
    pnlRodape: TPanel;
    pgcPrincipal: TPageControl;
    tabListagem: TTabSheet;
    Novo: TBitBtn;
    Alterar: TBitBtn;
    Cancelar: TBitBtn;
    Excluir: TBitBtn;
    btnNavigator: TDBNavigator;
    Sair: TBitBtn;
    tabManutencao: TTabSheet;
    pnlTopo: TPanel;
    grdPrincipal: TDBGrid;
    Salvar: TBitBtn;
    mskPesquisar: TMaskEdit;
    btnPesquisar: TBitBtn;
    lblPesquisar: TLabel;
    QryListagem: TZQuery;
    dtsListagem: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure SairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTelaHeranca: TfrmTelaHeranca;

implementation

{$R *.dfm}

//Criando conexão em Tempo de Execução
procedure TfrmTelaHeranca.FormCreate(Sender: TObject);
begin
  QryListagem.Connection := dtmPrincipal.ConexaoDB;
  dtsListagem.DataSet := QryListagem;
  grdPrincipal.DataSource := dtsListagem;
end;

//Fechando a Tela
procedure TfrmTelaHeranca.SairClick(Sender: TObject);
begin
  Close;
end;

end.
