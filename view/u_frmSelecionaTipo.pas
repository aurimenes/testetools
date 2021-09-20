unit u_frmSelecionaTipo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmSelecionaTipo = class(TForm)
    cmbTiposServico: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CodigosTipos: TStringList;
  end;

var
  frmSelecionaTipo: TfrmSelecionaTipo;

implementation

{$R *.dfm}

uses classTipo, controlTipo, uDM;

procedure TfrmSelecionaTipo.Button1Click(Sender: TObject);
begin
  if cmbTiposServico.ItemIndex < 0 then
  begin
    Application.MessageBox('Selecione o tipo do serviço!', 'Atenção', MB_ICONEXCLAMATION);
    Exit;
  end;

  ModalResult := mrOk;
end;

procedure TfrmSelecionaTipo.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmSelecionaTipo.FormCreate(Sender: TObject);
var
  ControleTipo: TControlTipo;
  Lista: TList;
  Cont: Integer;
begin
  CodigosTipos := TStringList.Create;
  ControleTipo := TControlTipo.Create(DM.DB);

  Lista := TList.Create;
  ControleTipo.Listar(Lista);

  cmbTiposServico.Clear;
  CodigosTipos.Clear;

  for Cont := 0 to Lista.Count - 1 do
  begin
    cmbTiposServico.Items.Add(TTipo(Lista[Cont]).Descricao);
    CodigosTipos.Add(IntToStr(TTipo(Lista[Cont]).Id));
  end;

  FreeAndNil(Lista);
end;

procedure TfrmSelecionaTipo.FormDestroy(Sender: TObject);
begin
  FreeAndNil(CodigosTipos);
end;

end.
