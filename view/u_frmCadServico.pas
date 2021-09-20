unit u_frmCadServico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Grids, daoFarmaceutico, classFarmaceutico, DaoPaciente,
  ClassPaciente, classServico, controlServico, classServicoItem;

type
  TfrmCadServico = class(TForm)
    Label1: TLabel;
    lblCodServico: TLabel;
    Label2: TLabel;
    cmbFarmaceutico: TComboBox;
    Label3: TLabel;
    cmbPaciente: TComboBox;
    Label4: TLabel;
    grdItens: TStringGrid;
    lblValorTotal: TLabel;
    Button1: TButton;
    Label5: TLabel;
    memObservacoes: TMemo;
    btnCancelar: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    ControleServ: TControlServico;
    CodFarmaceuticos: TStringList;
    CodPacientes: TStringList;
    procedure CarregaGrid;
  public
    { Public declarations }
    Servico: TServico;
  end;

var
  frmCadServico: TfrmCadServico;

implementation

{$R *.dfm}

uses uDM;

procedure TfrmCadServico.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadServico.Button1Click(Sender: TObject);
begin
  if cmbFarmaceutico.ItemIndex < 0 then
  begin
    cmbFarmaceutico.SetFocus;
    Application.MessageBox('Selecione o Farmacêutico!', 'Atenção', MB_ICONWARNING);
    Exit;
  end;

  if cmbPaciente.ItemIndex < 0 then
  begin
    cmbPaciente.SetFocus;
    Application.MessageBox('Selecione o Paciente!', 'Atenção', MB_ICONWARNING);
    Exit;
  end;

  Servico.Farmaceutico.Id := StrToInt(CodFarmaceuticos[cmbFarmaceutico.ItemIndex]);
  Servico.Paciente.Id := StrToInt(CodPacientes[cmbPaciente.ItemIndex]);
  Servico.Observacoes.Text := memObservacoes.Lines.Text;
  ControleServ.Gravar(Servico);
  Close;
end;

procedure TfrmCadServico.Button2Click(Sender: TObject);
var
  ItemServico: TServicoItem;
begin
  ItemServico := TServicoItem.Create;

  ItemServico.Id := 3;
  ItemServico.Valor := 7.5;
  ItemServico.Tipo.Id := 3;

  Servico.AdicionaItem(ItemServico);
end;

procedure TfrmCadServico.CarregaGrid;
var
  Cont: Integer;
begin
  grdItens.RowCount := 1;
  grdItens.ColCount := 2;
  grdItens.ColWidths[0] := 300;
  grdItens.ColWidths[1] := 75;
  grdItens.Cells[0, 0] := 'Descrição';
  grdItens.Cells[1, 0] := 'Valor';

  grdItens.RowCount := Servico.QtdItens + 1;

  for Cont := 0 to Servico.QtdItens - 1 do
  begin
    grdItens.Cells[0, Cont + 1] := Servico.RetornaItemPos(Cont).Tipo.Descricao;
    grdItens.Cells[1, Cont + 1] := FormatCurr(',0.00', Servico.RetornaItemPos(Cont).Valor);
  end;

  if grdItens.RowCount = 1 then
    grdItens.RowCount := 2;

  grdItens.FixedRows := 1;
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

  for Cont := 0 to Lista.Count - 1 do
  begin
    CodFarmaceuticos.Add(IntToStr(TFarmaceutico(Lista[Cont]).Id));
    cmbFarmaceutico.Items.Add(TFarmaceutico(Lista[Cont]).Nome);
    TFarmaceutico(Lista[Cont]).Free;
  end;

  { TODO : Limpar os itens da lista Anterior }

  DaoPaciente.Listar(Lista);

  for Cont := 0 to Lista.Count - 1 do
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
var
  CodServico: Integer;
begin
  if Servico.Id = 0 then
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
    memObservacoes.Text := Servico.Observacoes.Text;

    CarregaGrid;
  end;
end;

end.
