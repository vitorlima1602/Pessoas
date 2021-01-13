unit uTelaHeranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.UITypes, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, uDTMConexao, uEnum, RxToolEdit;

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
    grdListagem: TDBGrid;
    btnSalvar: TBitBtn;
    mskPesquisar: TMaskEdit;
    btnPesquisar: TBitBtn;
    lblIndice: TLabel;
    QryListagem: TZQuery;
    dtsListagem: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdListagemTitleClick(Column: TColumn);
    procedure mskPesquisarChange(Sender: TObject);
    procedure grdListagemDblClick(Sender: TObject);
  private
    { Private declarations }
    EstadoDoCadastro : TEstadoDoCadastro;
    procedure ControlarBotoes(btnNovo, btnAlterar,
          btnCancelar, btnSalvar, btnExcluir : TBitBtn;
          btnNavigator : TDBNavigator; pgcPrincipal : TPageControl; Flag : Boolean);
    procedure ControlarIndiceTab(pgcPrincipal : TPageControl; Indice: Integer);
    function RetornarCampoTraduzido(Campo: String): String;
    procedure ExibirLabelIndice(Campo: String; aLabel: TLabel);
    procedure DesabilitarEditPK;
    function ExisteCampoObrigatorio: Boolean;
    procedure LimparEdits;
  public
    { Public declarations }
    IndiceAtual : String;
    function Excluir : Boolean; virtual;
    function Salvar(EstadoDoCadastro : TEstadoDoCadastro) : Boolean; virtual;
  end;

var
  frmTelaHeranca: TfrmTelaHeranca;

implementation

{$R *.dfm}

{$region 'OBSERVAÇÕES'}
  //TAG: 1 - Chave Primária - PK
  //TAG: 2 - Campos Obrigatórios
{$endregion}

{$region 'EVENTOS'}

//Finalizando a Query ao fechar a janela
procedure TfrmTelaHeranca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  QryListagem.Close;
end;

//Criando conexão em Tempo de Execução
procedure TfrmTelaHeranca.FormCreate(Sender: TObject);
begin
  QryListagem.Connection := dtmPrincipal.ConexaoDB;
  dtsListagem.DataSet    := QryListagem;
  grdListagem.DataSource := dtsListagem;
  grdListagem.Options    := [dgTitles,dgIndicator,dgColumnResize,
                             dgColLines,dgRowLines,dgTabs,
                             dgRowSelect,dgAlwaysShowSelection,dgCancelOnExit,
                             dgTitleClick,dgTitleHotTrack];
end;

//Mostrar informações do banco
procedure TfrmTelaHeranca.FormShow(Sender: TObject);
begin
  if (QryListagem.SQL.Text <> EmptyStr) then
  begin
    QryListagem.IndexFieldNames := IndiceAtual;
    ExibirLabelIndice(IndiceAtual, lblIndice);
    QryListagem.Open;
  end;
  ControlarIndiceTab(pgcPrincipal, 0);
  DesabilitarEditPK;
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnSalvar,
                  btnExcluir, btnNavigator, pgcPrincipal, True);
end;

{$endregion}

{$region 'MÉTODOS VIRTUAIS'}
//Método Salvar
function TfrmTelaHeranca.Salvar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if (EstadoDoCadastro = ecInserir) then
      ShowMessage('Inserir')
  else if (EstadoDoCadastro = ecAlterar) then
           ShowMessage('Alterado');
  Result := True;
end;

//Método Excluir
function TfrmTelaHeranca.Excluir: Boolean;
begin
  ShowMessage('DELETADO');
  Result := True;
end;

{$endregion}

{$region 'FUNÇÕES E PRODECIMENTOS'}

//Procedimento para controlar botões
procedure TfrmTelaHeranca.ControlarBotoes(btnNovo, btnAlterar,
          btnCancelar, btnSalvar, btnExcluir : TBitBtn;
          btnNavigator : TDBNavigator; pgcPrincipal : TPageControl; Flag : Boolean);
begin

  //Ativando e desativando visibilidade dos botões
  btnNovo.Enabled                  := Flag;
  btnExcluir.Enabled               := Flag;
  btnAlterar.Enabled               := Flag;
  btnNavigator.Enabled             := Flag;
  pgcPrincipal.Pages[0].TabVisible := Flag;
  btnCancelar.Enabled              := not(Flag);
  btnSalvar.Enabled                := not(Flag);

end;

//Controle de visualização das páginas (Listagem/Manutenção)
procedure TfrmTelaHeranca.ControlarIndiceTab(pgcPrincipal : TPageControl; Indice: Integer);
begin
  if (pgcPrincipal.Pages[Indice].TabVisible) then
    begin
      pgcPrincipal.TabIndex := Indice;
    end;
end;

//Retorna o DisplayLabel do campo
function TfrmTelaHeranca.RetornarCampoTraduzido(Campo : String) : String;
var i : Integer;
  begin
  for I := 0 to QryListagem.Fields.Count - 1 do
    begin
      if lowercase(QryListagem.Fields[i].FieldName) = lowercase(Campo) then
        begin
          Result := QryListagem.Fields[i].DisplayLabel;
          Break;
        end;
    end;
end;


//Atualiza o label de pesquisa com o valor do field retornado
procedure TfrmTelaHeranca.ExibirLabelIndice(Campo : String; aLabel : TLabel);
begin
  aLabel.Caption := RetornarCampoTraduzido(Campo);
end;

//Clicar 2 vezes no grid para Alterar um registro
procedure TfrmTelaHeranca.grdListagemDblClick(Sender: TObject);
begin
  btnAlterar.Click;
end;

//Ordenar as informações do grid por coluna
//e alterar o label de pesquisa com o nome da coluna ai clicar sobre o mesmo
procedure TfrmTelaHeranca.grdListagemTitleClick(Column: TColumn);
begin
  IndiceAtual := Column.FieldName;
  QryListagem.IndexFieldNames := IndiceAtual;
  ExibirLabelIndice(IndiceAtual, lblIndice);
end;

//Pesquisa por digitação
procedure TfrmTelaHeranca.mskPesquisarChange(Sender: TObject);
begin
  QryListagem.Locate(IndiceAtual, TMaskEdit(Sender).Text, [loPartialKey]);
end;

//Desabilitar campos Primary Key
procedure TfrmTelaHeranca.DesabilitarEditPK;
var i : Integer;
begin
  for i := 0 to ComponentCount -1 do
    begin
      if (Components[i] is TLabeledEdit) then
        begin
          if (TLabeledEdit(Components[i]).Tag = 1) then
            begin
              TLabeledEdit(Components[i]).Enabled := False;
              Break;
            end;
        end;
    end;
end;

//Valida se o campo está preenchido (Verificação por TAG)
// TAG = 2 - Campo Obrigatório
function TfrmTelaHeranca.ExisteCampoObrigatorio : Boolean;
var i : Integer;
begin
  Result := False;
  for i := 0 to ComponentCount -1 do
    begin
      if (Components[i] is TLabeledEdit) then
        begin
          if (TLabeledEdit(Components[i]).Tag = 2) and (TLabeledEdit(Components[i]).Text = EmptyStr) then
            begin
              MessageDlg(TLabeledEdit(Components[i]).EditLabel.Caption + ' é um campo obrigatório ', mtInformation, [mbOK], 0);
              TLabeledEdit(Components[i]).SetFocus;
              Result := True;
              Break;
            end;
        end;
    end;
end;

procedure TfrmTelaHeranca.LimparEdits;
var i : Integer;
begin
  for i := 0 to ComponentCount -1 do
    begin
      if (Components[i] is TLabeledEdit) then
          TLabeledEdit(Components[i]).Text := EmptyStr
      else if (Components[i] is TEdit) then
        TEdit(Components[i]).Text := ''
      else if (Components[i] is TMaskEdit) then
        TMaskEdit(Components[i]).Text := ''
      else if (Components[i] is TMemo) then
        TMemo(Components[i]).Text := ''
      else if (Components[i] is TDBLookupComboBox) then
        TDBLookupComboBox(Components[i]).KeyValue := Null
      else if (Components[i] is TDateEdit) then
        TDateEdit(Components[i]).Date := 0;
    end;
end;

{$endregion}

{$region 'BOTÕES'}

//Botão Novo
procedure TfrmTelaHeranca.btnNovoClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnSalvar,
                  btnExcluir, btnNavigator, pgcPrincipal, False);
  EstadoDoCadastro := ecInserir;
  LimparEdits;
end;

//Botão Alterar
procedure TfrmTelaHeranca.btnAlterarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnSalvar,
                  btnExcluir, btnNavigator, pgcPrincipal, False);
  EstadoDoCadastro := ecAlterar;
end;

//Botão Cancelar
procedure TfrmTelaHeranca.btnCancelarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnSalvar,
                  btnExcluir, btnNavigator, pgcPrincipal, True);
  ControlarIndiceTab(pgcPrincipal, 0);
  EstadoDoCadastro := ecNenhum;
  LimparEdits;
end;

//Botão Salvar
procedure TfrmTelaHeranca.btnSalvarClick(Sender: TObject);
begin
  if (ExisteCampoObrigatorio) then
    begin
      Abort;
    end;
  Try
    if Salvar(EstadoDoCadastro) then
      begin
        ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnSalvar,
                        btnExcluir, btnNavigator, pgcPrincipal, True);
        ControlarIndiceTab(pgcPrincipal, 0);
        EstadoDoCadastro := ecNenhum;
        LimparEdits;
        QryListagem.Refresh;
      end
    else
      begin
        MessageDlg('Erro na Gravação', mtError, [mbOK], 0);
      end;
  Finally
  End;
end;

//Botão Excluir
procedure TfrmTelaHeranca.btnExcluirClick(Sender: TObject);
begin
  Try
    if Excluir then
      begin
        ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnSalvar,
                  btnExcluir, btnNavigator, pgcPrincipal, True);
        ControlarIndiceTab(pgcPrincipal, 0);
        EstadoDoCadastro := ecNenhum;
        LimparEdits;
        QryListagem.Refresh;
      end
    else
      begin
        MessageDlg('Erro na Exclusão', mtError, [mbOK], 0);
      end;
  Finally
    EstadoDoCadastro := ecNenhum;
  End;

end;

//Fechando a Tela
procedure TfrmTelaHeranca.btnSairClick(Sender: TObject);
begin
  Close;
end;
{$endregion}

end.
