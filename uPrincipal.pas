unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uDTMConexao;

type
  TfrmPrincipal = class(TForm)
    menuPrincipal: TMainMenu;
    CadastrodePessoa1: TMenuItem;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

//Estrutura de conexão com o banco de dados ao iniciar aplicação
procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  dtmPrincipal := TdtmPrincipal.Create(Self);
  with dtmPrincipal.ConexaoDB do
  begin
    Protocol := 'mssql';
    LibraryLocation := 'C:\Delphi\Pessoas\ntwdblib.dll';
    HostName := '.\SQLEXPRESS';
    Port := 1433;
    User := 'userAppDelphi';
    Password := 'server2019';
    Database := 'Cadastro_Pessoas';
    Connected := True;


  end;

end;

end.
