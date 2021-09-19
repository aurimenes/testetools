unit u_frmCadServico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Grids, daoFarmaceutico, classFarmaceutico, DaoPaciente,
  ClassPaciente, classServico, controlServico;

type
  TfrmCadServico = class(TForm)
    Label1: TLabel;
    lblCodServico: TLabel;
    Label2: TLabel;
    cmbFarmaceutico: TComboBox;
    Label3: TLabel;
    cmbPaciente: TComboBox;
    Label4: TLabel;
    StringGrid1: TStringGrid;
    lblValorTotal: TLabel;
    Button1: TButton;
    Label5: TLabel;
    memObservacoes: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    ControleServ: TControlServico;
    CodFarmaceuticos: TStringList;
    CodPacientes: TStringList;
  public
    { Public declarations }
    Servico: TServico;
  end;

var
  frmCadServico: TfrmCadServico;

implementation

{$R *.dfm}

uses uDM;

procedure TfrmCadServico.Button1Click(Sender: TObject);
begin
  Servico.Farmaceutico.Id := StrToInt(CodFarmaceuticos[cmbFarmaceutico.ItemIndex]);
  Servico.Paciente.Id := StrToInt(CodPacientes[cmbPaciente.ItemIndex]);
  Servico.Observacoes.Text := memObservacoes.Lines.Text;
  ControleServ.Gravar(Servico);
  Close;
end;

procedure TfrmCadServico.FormCreate(Sender: TObject);
var
  Lista: TList;
  Cont: Integer;
  DaoFarmaceutico: TDaoFarmaceutico;
  DaoPaciente: TDaoPaciente;
begin
  CodFarmaceuticos := TStringList.Create;
  CodPacientes := TStringList.Create;
  Lista := TList.Create;
  DaoFarmaceutico := TDaoFarmaceutico.Create(DM.DB);
  DaoPaciente := TDaoPaciente.Create(DM.DB);
  cmbFarmaceutico.Clear;
  cmbPaciente.Clear;

  DaoFarmaceutico.Listar(Lista);

  for cont := 0 to Lista.Count - 1 do
  begin
    CodFarmaceuticos.Add(IntToStr(TFarmaceutico(Lista[Cont]).Id));
    cmbFarmaceutico.Items.Add(TFarmaceutico(Lista[Cont]).Nome);
    TFarmaceutico(Lista[Cont]).Free;
  end;

  { TODO : Limpar os itens da lista Anterior }

  DaoPaciente.Listar(Lista);

  for cont := 0 to Lista.Count - 1 do
  begin
    CodPacientes.Add(IntToStr(TPaciente(Lista[Cont]).Id));
    cmbPaciente.Items.Add(TPaciente(Lista[Cont]).Nome);
    TPaciente(Lista[Cont]).Free
  end;

  Servico := TServico.Create;
  ControleServ := TControlServico.Create(DM.DB);
end;

procedure TfrmCadServico.FormDestroy(Sender: TObject);
begin
  FreeAndNil(CodFarmaceuticos);
  FreeAndNil(CodPacientes);
  FreeAndNil(Servico);
  FreeAndNil(ControleServ);
end;

procedure TfrmCadServico.FormShow(Sender: TObject);
begin
  if Servico.Id = -1 then
  begin
    lblCodServico.Caption := '<novo serviço>';
    lblValorTotal.Caption := '0,00';
  end
  else
  begin
    Servico := TServico(ControleServ.Carregar(Servico.Id));
    lblCodServico.Caption := IntToStr(Servico.Id);
    cmbFarmaceutico.ItemIndex := cmbFarmaceutico.Items.IndexOf(Servico.Farmaceutico.Nome);
    cmbPaciente.ItemIndex := cmbPaciente.Items.IndexOf(Servico.Paciente.Nome);
    lblValorTotal.Caption := FormatCurr(',0.00', Servico.ValorTotal);
  end;
end;

end.
