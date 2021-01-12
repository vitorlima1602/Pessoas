unit uTelaHeranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, uDTMConexao, uEnum;

type
  TfrmTelaHeranca = class(TForm)
    pnlRodape: TPanel;
    pgcPrincipal: TPageControl;
    tabListagem: TTabSheet;
    btnNovo: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    btnNavigator: TDBNavigator;
    btnSair: TBitBtn;
    tabManutencao: TTabSheet;
    pnlTopo: TPanel;
    grdPrincipal: TDBGrid;
    btnSalvar: TBitBtn;
    mskPesquisar: TMaskEdit;
    btnPesquisar: TBitBtn;
    lblPesquisar: TLabel;
    QryListagem: TZQuery;
    dtsListagem: TDataSource;
    QryListagemnome: TWideStringField;
    QryListagemcpf: TWideStringField;
    QryListagemrg: TWideStringField;
    QryListagemdata_nascimento: TWideStringField;
    QryListagemidPessoa: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
    EstadoDoCadastro : TEstadoDoCadastro;
    procedure ControlarBotoes(btnNovo, btnAlterar,
          btnCancelar, btnSalvar, btnExcluir : TBitBtn;
          btnNavigator : TDBNavigator; pgcPrincipal : TPageControl; Flag : Boolean);
    procedure ControlarIndiceTab(pgcPrincipal : TPageControl; Indice: Integer);
  public
    { Public declarations }
  end;

var
  frmTelaHeranca: TfrmTelaHeranca;

implementation

{$R *.dfm}

{$region 'EVENTOS DO FORM'}

//Criando conex�o em Tempo de Execu��o
procedure TfrmTelaHeranca.FormCreate(Sender: TObject);
begin
  QryListagem.Connection := dtmPrincipal.ConexaoDB;
  dtsListagem.DataSet := QryListagem;
  grdPrincipal.DataSource := dtsListagem;
end;

{$endregion}

{$region 'FUN��ES E PROCEDIMENTOS'}

//Procedimento para controlar bot�es
procedure TfrmTelaHeranca.ControlarBotoes(btnNovo, btnAlterar,
          btnCancelar, btnSalvar, btnExcluir : TBitBtn;
          btnNavigator : TDBNavigator; pgcPrincipal : TPageControl; Flag : Boolean);
begin

  //Ativando e desativando visibilidade dos bot�es
  btnNovo.Enabled                  := Flag;
  btnExcluir.Enabled               := Flag;
  btnAlterar.Enabled               := Flag;
  btnNavigator.Enabled             := Flag;
  pgcPrincipal.Pages[0].TabVisible := Flag;
  btnCancelar.Enabled              := not(Flag);
  btnSalvar.Enabled                := not(Flag);

end;

//Controle de visualiza��o das p�ginas (Listagem/Manuten��o)
procedure TfrmTelaHeranca.ControlarIndiceTab(pgcPrincipal : TPageControl; Indice: Integer);
begin
  if (pgcPrincipal.Pages[Indice].TabVisible) then
      pgcPrincipal.TabIndex := Indice;
end;

{$endregion}

{$region 'BOT�ES'}

//Bot�o Novo
procedure TfrmTelaHeranca.btnNovoClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnSalvar,
                  btnExcluir, btnNavigator, pgcPrincipal, False);
  EstadoDoCadastro := ecInserir;
end;

//Bot�o Alterar
procedure TfrmTelaHeranca.btnAlterarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnSalvar,
                  btnExcluir, btnNavigator, pgcPrincipal, False);
  EstadoDoCadastro := ecAlterar;
end;

//Bot�o Cancelar
procedure TfrmTelaHeranca.btnCancelarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnSalvar,
                  btnExcluir, btnNavigator, pgcPrincipal, True);
  ControlarIndiceTab(pgcPrincipal, 0);
  EstadoDoCadastro := ecNenhum;
end;

//Bot�o Salvar
procedure TfrmTelaHeranca.btnSalvarClick(Sender: TObject);
begin
  Try
    ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnSalvar,
                  btnExcluir, btnNavigator, pgcPrincipal, True);
    ControlarIndiceTab(pgcPrincipal, 0);
    EstadoDoCadastro := ecNenhum;

    MessageDlg('Erro na Grava��o', mtError, [mbOK], 0);

  Finally

  End;

end;

//Bot�o Excluir
procedure TfrmTelaHeranca.btnExcluirClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnSalvar,
                  btnExcluir, btnNavigator, pgcPrincipal, True);
  ControlarIndiceTab(pgcPrincipal, 0);
  EstadoDoCadastro := ecNenhum;
end;

//Fechando a Tela
procedure TfrmTelaHeranca.btnSairClick(Sender: TObject);
begin
  Close;
end;
{$endregion}

end.
