inherited frmCadPessoa: TfrmCadPessoa
  Caption = 'Cadastro de Pessoa'
  ClientHeight = 388
  ClientWidth = 1025
  ExplicitWidth = 1041
  ExplicitHeight = 427
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlRodape: TPanel
    Top = 343
    Width = 1025
    ExplicitTop = 343
    ExplicitWidth = 946
    inherited btnNavigator: TDBNavigator
      Left = 399
      Width = 136
      Hints.Strings = ()
      ExplicitLeft = 399
      ExplicitWidth = 136
    end
    inherited btnSair: TBitBtn
      Left = 946
      ExplicitLeft = 867
    end
  end
  inherited pgcPrincipal: TPageControl
    Width = 1025
    Height = 343
    ExplicitWidth = 946
    ExplicitHeight = 343
    inherited tabListagem: TTabSheet
      ExplicitWidth = 938
      ExplicitHeight = 315
      inherited pnlTopo: TPanel
        Width = 1017
        ExplicitWidth = 938
      end
      inherited grdPrincipal: TDBGrid
        Width = 1017
        Height = 242
        Columns = <
          item
            Expanded = False
            FieldName = 'idPessoa'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Width = 196
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'telefone'
            Width = 82
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'data_nascimento'
            Width = 101
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'logradouro'
            Width = 209
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'numero'
            Width = 46
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cep'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cidade'
            Width = 204
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'uf'
            Width = 23
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitWidth = 938
      ExplicitHeight = 315
      object Label2: TLabel
        Left = 13
        Top = 159
        Width = 19
        Height = 13
        Caption = 'CPF'
      end
      object Label3: TLabel
        Left = 157
        Top = 159
        Width = 14
        Height = 13
        Caption = 'RG'
      end
      object Telefone: TLabel
        Left = 11
        Top = 110
        Width = 42
        Height = 13
        Caption = 'Telefone'
      end
      object Label1: TLabel
        Left = 292
        Top = 159
        Width = 96
        Height = 13
        Caption = 'Data de Nascimento'
      end
      object Label4: TLabel
        Left = 574
        Top = 211
        Width = 19
        Height = 13
        Caption = 'CEP'
      end
      object edtIdPessoa: TLabeledEdit
        Left = 10
        Top = 32
        Width = 121
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 0
      end
      object edtNome: TLabeledEdit
        Left = 10
        Top = 80
        Width = 431
        Height = 21
        EditLabel.Width = 27
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome'
        MaxLength = 60
        TabOrder = 1
      end
      object mskCpf: TMaskEdit
        Left = 11
        Top = 174
        Width = 142
        Height = 21
        EditMask = '999.999.999-99;1;_'
        MaxLength = 14
        TabOrder = 2
        Text = '   .   .   -  '
      end
      object mskRg: TMaskEdit
        Left = 157
        Top = 174
        Width = 132
        Height = 21
        EditMask = '99.999.999-9;1;_'
        MaxLength = 12
        TabOrder = 3
        Text = '  .   .   - '
      end
      object mskTelefone: TMaskEdit
        Left = 11
        Top = 125
        Width = 142
        Height = 21
        EditMask = '(99) 9999-9999;1;_'
        MaxLength = 14
        TabOrder = 4
        Text = '(  )     -    '
      end
      object DateEdit1: TDateEdit
        Left = 292
        Top = 174
        Width = 149
        Height = 21
        NumGlyphs = 2
        TabOrder = 5
      end
      object edtLogradouro: TLabeledEdit
        Left = 13
        Top = 225
        Width = 428
        Height = 21
        EditLabel.Width = 55
        EditLabel.Height = 13
        EditLabel.Caption = 'Logradouro'
        MaxLength = 60
        TabOrder = 6
      end
      object mskCep: TMaskEdit
        Left = 574
        Top = 225
        Width = 155
        Height = 21
        EditMask = '99.999-999;1;_'
        MaxLength = 10
        TabOrder = 7
        Text = '  .   -   '
      end
      object edtBairro: TLabeledEdit
        Left = 13
        Top = 270
        Width = 428
        Height = 21
        EditLabel.Width = 28
        EditLabel.Height = 13
        EditLabel.Caption = 'Bairro'
        MaxLength = 50
        TabOrder = 8
      end
      object edtCidade: TLabeledEdit
        Left = 447
        Top = 270
        Width = 247
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'Cidade'
        MaxLength = 60
        TabOrder = 9
      end
      object edtNumero: TLabeledEdit
        Left = 447
        Top = 225
        Width = 121
        Height = 21
        EditLabel.Width = 37
        EditLabel.Height = 13
        EditLabel.Caption = 'N'#250'mero'
        MaxLength = 6
        TabOrder = 10
      end
      object edtUf: TLabeledEdit
        Left = 700
        Top = 270
        Width = 29
        Height = 21
        EditLabel.Width = 13
        EditLabel.Height = 13
        EditLabel.Caption = 'UF'
        MaxLength = 2
        TabOrder = 11
      end
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      
        'SELECT idPessoa, nome, telefone, cpf, rg, data_nascimento, logra' +
        'douro, numero, cep, bairro, cidade, uf'
      #9'FROM PESSOA')
    Left = 816
    Top = 40
    object QryListagemtelefone: TWideStringField [2]
      DisplayLabel = 'Telefone'
      FieldName = 'telefone'
      Size = 12
    end
    object QryListagemlogradouro: TWideStringField
      DisplayLabel = 'Logradouro'
      FieldName = 'logradouro'
      Size = 60
    end
    object QryListagemnumero: TIntegerField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'numero'
    end
    object QryListagemcep: TWideStringField
      DisplayLabel = 'CEP'
      FieldName = 'cep'
      Size = 10
    end
    object QryListagembairro: TWideStringField
      DisplayLabel = 'Bairro'
      FieldName = 'bairro'
      Size = 50
    end
    object QryListagemcidade: TWideStringField
      DisplayLabel = 'Cidade'
      FieldName = 'cidade'
      Size = 60
    end
    object QryListagemuf: TWideStringField
      DisplayLabel = 'UF'
      FieldName = 'uf'
      Size = 2
    end
  end
  inherited dtsListagem: TDataSource
    Left = 880
    Top = 40
  end
end
