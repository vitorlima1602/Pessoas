unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uDTMConexao, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmPrincipal = class(TForm)
    menuPrincipal: TMainMenu;
    CadastrodePessoa1: TMenuItem;
    Pessoa1: TMenuItem;
    imgPrincipal: TImage;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Pessoa1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uCadPessoa;

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
    User := 'vl';
    Password := 'server2019';
    Database := 'Teste';
    Connected := True;
  end;
end;

procedure TfrmPrincipal.Pessoa1Click(Sender: TObject);
begin
  frmCadPessoa := TfrmCadPessoa.Create(Self);
  frmCadPessoa.ShowModal;
  frmCadPessoa.Release;
end;

end.
