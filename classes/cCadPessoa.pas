unit cCadPessoa;

interface

//Lista de Units utilizadas
uses System.Classes,
     Vcl.Controls,
     Vcl.ExtCtrls,
     Vcl.Dialogs,
     ZAbstractConnection,
     ZConnection,
     ZAbstractRODataset,
     ZAbstractDataset,
     ZDataset,
     System.SysUtils;

type
  //Declaração do tipo da Classe
  TPessoa = class

  private
  //Variáveis privadas que são utilizadas somente dentro da classe
  //Definindo o tipo das propriedades
    ConexaoDB : TZConnection;
    F_idPessoa : Integer;
    F_nome : String;
    F_telefone : String;
    F_cpf : String;
    F_rg : String;
    F_data_nascimento : TDateTime;
    F_logradouro : String;
    F_numero : Integer;
    F_cep : String;
    F_bairro : String;
    F_cidade : String;
    F_uf : String;

  public
  //Variáveis públicas que podem ser trabalhadas fora da classe
  // Definição dos métodos Constructor e Destructor e funções para CRUD
    constructor Create (aConexao : TZConnection);
    destructor Destroy; override; //Sobrescrita de método
    function Inserir : Boolean;
    function Atualizar : Boolean;
    function Excluir : Boolean;
    function Selecionar(id : Integer) : Boolean;

  published
  //Variáveis públicas utilizadas para propriedades da classe
  // Definição de propriedades de escrita e leitura
    property codigo          : Integer     read F_idPessoa          write F_idPessoa;
    property nome            : String      read F_nome              write F_nome;
    property telefone        : String      read F_telefone          write F_telefone;
    property cpf             : String      read F_cpf               write F_cpf;
    property rg              : String      read F_rg                write F_rg;
    property data_nascimento : TDateTime   read F_data_nascimento   write F_data_nascimento;
    property logradouro      : String      read F_logradouro        write F_logradouro;
    property numero          : Integer     read F_numero            write F_numero;
    property cep             : String      read F_cep               write F_cep;
    property bairro          : String      read F_bairro            write F_bairro;
    property cidade          : String      read F_cidade            write F_cidade;
    property uf              : String      read F_uf                write F_uf;
  end;

  //Área de implementação
implementation

{$region 'Constructor e Destructor'}

//Construtor da Classe
constructor TPessoa.Create(aConexao : TZConnection);
begin
  ConexaoDB := aConexao;
end;

//Destroi a Classe
destructor TPessoa.Destroy;
begin
  inherited;
end;

{$endregion}

{$region 'CRUD'}

function TPessoa.Excluir : Boolean;
// Variável do tipo TZQuery
var Qry : TZQuery;

begin
  //Mensagem para confirmação de exclusão do registro
  if MessageDlg('Excluir o registro: ' +#13+#13+
                'Código ' + IntToStr(F_idPessoa) +#13+
                'Descrição: ' + F_nome, mtConfirmation, [mbYes, mbNo], 0 ) = mrNo then
    begin
      Result := False;
      Abort;
    end;

    try
      Result := True;

      //Cria uma Query
      Qry := TZQuery.Create(nil);
      //Cria uma conexão com o banco
      Qry.Connection := ConexaoDB;
      //Limpa a Query
      Qry.SQL.Clear;
      //Código SQL
      Qry.SQL.Add('DELETE FROM PESSOA ' +
                  ' WHERE idPessoa=:idPessoa ');
      Qry.ParamByName('idPessoa').AsInteger := F_idPessoa;

      Try
        //Tentará executar o comando SQL
        Qry.ExecSQL;
      Except
        //Retornará falso em caso de exceção
        Result := False;
      End;

    finally
      //Caso a Query ainda está em memória, ela será destruída
      if Assigned(Qry) then
        FreeAndNil(Qry);
    end;
end;

function TPessoa.Atualizar : Boolean;
// Variável do tipo TZQuery
var Qry : TZQuery;
begin
    try
      Result := True;

      //Cria uma Query
      Qry := TZQuery.Create(nil);
      //Cria uma conexão com o banco
      Qry.Connection := ConexaoDB;
      //Limpa a Query
      Qry.SQL.Clear;
      //Código SQL
      Qry.SQL.Add('UPDATE PESSOA ' +
                  '   SET nome             =:nome ' +
                  '       ,telefone        =:telefone ' +
                  '       ,cpf             =:cpf ' +
                  '       ,rg              =:rg ' +
                  '       ,data_nascimento =:data_nascimento ' +
                  '       ,logradouro      =:logradouro ' +
                  '       ,numero          =:numero ' +
                  '       ,cep             =:cep ' +
                  '       ,bairro          =:bairro ' +
                  '       ,cidade          =:cidade ' +
                  '       ,uf              =:uf ' +
                  ' WHERE idPessoa=:idPessoa ');

      Qry.ParamByName('idPessoa').AsInteger         := Self.F_idPessoa;
      Qry.ParamByName('nome').AsString              := Self.F_nome;
      Qry.ParamByName('telefone').AsString          := Self.F_telefone;
      Qry.ParamByName('cpf').AsString               := Self.F_cpf;
      Qry.ParamByName('rg').AsString                := Self.F_rg;
      Qry.ParamByName('data_nascimento').AsDateTime := Self.F_data_nascimento;
      Qry.ParamByName('logradouro').AsString        := Self.F_logradouro;
      Qry.ParamByName('numero').AsInteger           := Self.F_numero;
      Qry.ParamByName('cep').AsString               := Self.F_cep;
      Qry.ParamByName('bairro').AsString            := Self.F_bairro;
      Qry.ParamByName('cidade').AsString            := Self.F_cidade;
      Qry.ParamByName('uf').AsString                := Self.F_uf;

      Try
        //Tentará executar o comando SQL
        Qry.ExecSQL;
      Except
        //Retornará falso em caso de exceção
        Result := False;
      End;

    finally
      //Caso a Query ainda está em memória, ela será destruída
      if Assigned(Qry) then
        FreeAndNil(Qry);
    end;
end;

function TPessoa.Inserir : Boolean;
// Variável do tipo TZQuery
var Qry : TZQuery;
begin
    try
      Result := True;

      //Cria uma Query
      Qry := TZQuery.Create(nil);
      //Cria uma conexão com o banco
      Qry.Connection := ConexaoDB;
      //Limpa a Query
      Qry.SQL.Clear;
      //Código SQL
      Qry.SQL.Add('INSERT INTO PESSOA (nome, ' +
                  '                    telefone, ' +
                  '                    cpf, ' +
                  '                    rg, ' +
                  '                    data_nascimento, ' +
                  '                    logradouro, ' +
                  '                    numero, ' +
                  '                    cep, ' +
                  '                    bairro, ' +
                  '                    cidade, ' +
                  '                    uf)' +
                  ' VALUES            (:nome, ' +
                  '                    :telefone, ' +
                  '                    :cpf, ' +
                  '                    :rg, ' +
                  '                    :data_nascimento, ' +
                  '                    :logradouro, ' +
                  '                    :numero, ' +
                  '                    :cep, ' +
                  '                    :bairro, ' +
                  '                    :cidade, ' +
                  '                    :uf)');

      Qry.ParamByName('nome').AsString              := Self.F_nome;
      Qry.ParamByName('telefone').AsString          := Self.F_telefone;
      Qry.ParamByName('cpf').AsString               := Self.F_cpf;
      Qry.ParamByName('rg').AsString                := Self.F_rg;
      Qry.ParamByName('data_nascimento').AsDateTime := Self.F_data_nascimento;
      Qry.ParamByName('logradouro').AsString        := Self.F_logradouro;
      Qry.ParamByName('numero').AsInteger           := Self.F_numero;
      Qry.ParamByName('cep').AsString               := Self.F_cep;
      Qry.ParamByName('bairro').AsString            := Self.F_bairro;
      Qry.ParamByName('cidade').AsString            := Self.F_cidade;
      Qry.ParamByName('uf').AsString                := Self.F_uf;

      Try
        //Tentará executar o comando SQL
        Qry.ExecSQL;
      Except
        //Retornará falso em caso de exceção
        Result := False;
      End;

    finally
      //Caso a Query ainda está em memória, ela será destruída
      if Assigned(Qry) then
        FreeAndNil(Qry);
    end;
end;

function TPessoa.Selecionar(id: Integer) : Boolean;
// Variável do tipo TZQuery
var Qry : TZQuery;
begin
    try
      Result := True;

      //Cria uma Query
      Qry := TZQuery.Create(nil);
      //Cria uma conexão com o banco
      Qry.Connection := ConexaoDB;
      //Limpa a Query
      Qry.SQL.Clear;
      //Código SQL
      Qry.SQL.Add('SELECT idPessoa, ' +
                  '       nome, ' +
                  '       telefone, ' +
                  '       cpf, ' +
                  '       rg, ' +
                  '       data_nascimento, ' +
                  '       logradouro, ' +
                  '       numero, ' +
                  '       cep, ' +
                  '       bairro, ' +
                  '       cidade, ' +
                  '       uf ' +
                  '   FROM PESSOA ' +
                  ' WHERE idPessoa=:idPessoa');

      Qry.ParamByName('idPessoa').AsInteger := id;

      Try
        //Tentará abrir a Query
        Qry.Open;

        //Os campos receberão os valores do banco
        Self.F_idPessoa        := Qry.FieldByName('idPessoa').AsInteger;
        Self.F_nome            := Qry.FieldByName('nome').AsString;
        Self.F_telefone        := Qry.FieldByName('telefone').AsString;
        Self.F_cpf             := Qry.FieldByName('cpf').AsString;
        Self.F_rg              := Qry.FieldByName('rg').AsString;
        Self.F_data_nascimento := Qry.FieldByName('data_nascimento').AsDateTime;
        Self.F_logradouro      := Qry.FieldByName('logradouro').AsString;
        Self.F_numero          := Qry.FieldByName('numero').AsInteger;
        Self.F_cep             := Qry.FieldByName('cep').AsString;
        Self.F_bairro          := Qry.FieldByName('bairro').AsString;
        Self.F_cidade          := Qry.FieldByName('cidade').AsString;
        Self.F_uf              := Qry.FieldByName('uf').AsString;

      Except
        //Retornará falso em caso de exceção
        Result := False;
      End;

    finally
      //Caso a Query ainda está em memória, ela será destruída
      if Assigned(Qry) then
        FreeAndNil(Qry);
    end;
end;


{$endregion}

end.
