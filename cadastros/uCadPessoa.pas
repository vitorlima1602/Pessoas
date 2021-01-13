unit uCadPessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.DBCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  RxToolEdit, cCadPessoa, uEnum, uDTMConexao;

type
  TfrmCadPessoa = class(TfrmTelaHeranca)
    edtIdPessoa: TLabeledEdit;
    edtNome: TLabeledEdit;
    mskCpf: TMaskEdit;
    Label2: TLabel;
    mskRg: TMaskEdit;
    mskTelefone: TMaskEdit;
    Label3: TLabel;
    Telefone: TLabel;
    Label1: TLabel;
    edtLogradouro: TLabeledEdit;
    mskCep: TMaskEdit;
    Label4: TLabel;
    edtBairro: TLabeledEdit;
    edtCidade: TLabeledEdit;
    edtNumero: TLabeledEdit;
    edtDataNascimento: TDateEdit;
    QryListagemtelefone: TWideStringField;
    QryListagemlogradouro: TWideStringField;
    QryListagemnumero: TIntegerField;
    QryListagemcep: TWideStringField;
    QryListagembairro: TWideStringField;
    QryListagemcidade: TWideStringField;
    QryListagemuf: TWideStringField;
    edtUf: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure edtDataNascimentoChange(Sender: TObject);
  private
    { Private declarations }
    oPessoa : TPessoa;
  public
    { Public declarations }
    function Excluir : Boolean; override;
    function Salvar (EstadoDoCadastro : TEstadoDoCadastro) : Boolean; override;
  end;

var
  frmCadPessoa: TfrmCadPessoa;

implementation

{$R *.dfm}

{$region 'BOTÕES'}

//Botão Novo
procedure TfrmCadPessoa.btnNovoClick(Sender: TObject);
begin
  inherited;
  //Carregado com a data atual
  edtNome.SetFocus;
end;


//Botão Alterar
procedure TfrmCadPessoa.btnAlterarClick(Sender: TObject);
begin
  //Os campos do form receberam os valores providos do banco de dados
  if oPessoa.Selecionar(QryListagem.FieldByName('idPessoa').AsInteger) then
    begin
      edtIdPessoa.Text       := IntToStr(oPessoa.codigo);
      edtNome.Text           := oPessoa.nome;
      mskTelefone.Text       := oPessoa.telefone;
      mskCpf.Text            := oPessoa.cpf;
      mskRg.Text             := oPessoa.rg;
      edtDataNascimento.Date := oPessoa.data_nascimento;
      edtLogradouro.Text     := oPessoa.logradouro;
      edtNumero.Text         := IntToStr(oPessoa.numero);
      mskCep.Text            := oPessoa.cep;
      edtBairro.Text         := oPessoa.bairro;
      edtCidade.Text         := oPessoa.cidade;
      edtUf.Text             := oPessoa.uf;
    end
  else
    begin
      btnCancelar.Click;
      Abort;
    end;
  inherited;
end;

{$endregion}

{$region 'METODOS OVERRIDE'}

//Método Excluir
function TfrmCadPessoa.Excluir: Boolean;
begin
  //Exclui o registro baseado no Id
  if oPessoa.Selecionar(QryListagem.FieldByName('idPessoa').AsInteger) then
      Result := oPessoa.Excluir
end;

//Método Salvar
function TfrmCadPessoa.Salvar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  //Se for Update, o campo código do form receberá o valor do Id da tabela
  if edtIdPessoa.Text <> EmptyStr then
    oPessoa.codigo := StrToInt(edtIdPessoa.Text)
  else
    oPessoa.codigo := 0;

    //Se for Update, carrega o valor dos campos da tabela
    // para os campos do form
    oPessoa.nome            := edtNome.Text;
    oPessoa.telefone        := mskTelefone.Text;
    oPessoa.cpf             := mskCpf.Text;
    oPessoa.rg              := mskRg.Text;
    oPessoa.data_nascimento := edtDataNascimento.Date;
    oPessoa.logradouro      := edtLogradouro.Text;
    oPessoa.numero          := StrToInt(edtNumero.Text);
    oPessoa.cep             := mskCep.Text;
    oPessoa.bairro          := edtBairro.Text;
    oPessoa.cidade          := edtCidade.Text;
    oPessoa.uf              := edtUf.Text;

    //Verifica qual operação está sendo realizada
    if (EstadoDoCadastro = ecInserir) then
      Result := oPessoa.Inserir
    else if (EstadoDoCadastro = ecAlterar) then
      Result := oPessoa.Atualizar
end;

{$endregion}

{$region 'EVENTOS'}

//Fechamento do Form
procedure TfrmCadPessoa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  //Se existir uma instancia
  //Limpar a mesma da memória
  if Assigned(oPessoa) then
    begin
      FreeAndNil(oPessoa);
    end;

end;

//Criação do Form
procedure TfrmCadPessoa.FormCreate(Sender: TObject);
begin
  inherited;
  //Criação de conexão com o banco
  oPessoa := TPessoa.Create(dtmPrincipal.ConexaoDB);
  IndiceAtual := 'nome';
end;

{$endregion}

end.
