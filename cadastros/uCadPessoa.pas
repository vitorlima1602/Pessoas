unit uCadPessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.DBCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  RxToolEdit;

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
    DateEdit1: TDateEdit;
    Label1: TLabel;
    edtLogradouro: TLabeledEdit;
    mskCep: TMaskEdit;
    Label4: TLabel;
    edtBairro: TLabeledEdit;
    edtCidade: TLabeledEdit;
    edtNumero: TLabeledEdit;
    QryListagemtelefone: TWideStringField;
    QryListagemlogradouro: TWideStringField;
    QryListagemnumero: TIntegerField;
    QryListagemcep: TWideStringField;
    QryListagembairro: TWideStringField;
    QryListagemcidade: TWideStringField;
    QryListagemuf: TWideStringField;
    edtUf: TLabeledEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadPessoa: TfrmCadPessoa;

implementation

{$R *.dfm}

end.
