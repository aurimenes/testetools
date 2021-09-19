unit u_frmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls,
  Vcl.Buttons;

type
  TfrmPrincipal = class(TForm)
    Panel1: TPanel;
    grdServicos: TStringGrid;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Panel2: TPanel;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    procedure CarregaGrid;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uDM, classServico, controlServico, u_frmCadServico;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  CarregaGrid;
end;

procedure TfrmPrincipal.SpeedButton1Click(Sender: TObject);
begin
  frmCadServico := TfrmCadServico.Create(Self);
  frmCadServico.Servico.Id := -1; // Novo Serviço
  frmCadServico.ShowModal;
  FreeAndNil(frmCadServico);

  CarregaGrid;
end;

procedure TfrmPrincipal.SpeedButton2Click(Sender: TObject);
begin
  frmCadServico := TfrmCadServico.Create(Self);
  frmCadServico.Servico.Id := StrToInt(grdServicos.Cells[0, grdServicos.Row]); // Serviço Existente
  frmCadServico.ShowModal;
  FreeAndNil(frmCadServico);

  CarregaGrid;
end;

procedure TfrmPrincipal.CarregaGrid;
var
  Lista: TList;
  ControleServico: TControlServico;
  Cont: Integer;
begin
  Lista := TList.Create;
  ControleServico := TControlServico.Create(DM.DB);
  ControleServico.Listar(Lista);
  grdServicos.RowCount := 0;
  grdServicos.ColWidths[0] := 30;
  grdServicos.ColWidths[1] := 200;
  grdServicos.ColWidths[2] := 200;
  grdServicos.ColWidths[3] := 250;
  grdServicos.ColWidths[4] := 75;
  grdServicos.Cells[0, 0] := '#';
  grdServicos.Cells[1, 0] := 'Farmacêutico';
  grdServicos.Cells[2, 0] := 'Paciente';
  grdServicos.Cells[3, 0] := 'Observações';
  grdServicos.Cells[4, 0] := 'Valor Unit.';
  try
    grdServicos.ColCount := 5;
    for Cont := 0 to Lista.Count - 1 do
    begin
      grdServicos.RowCount := grdServicos.RowCount + 1;
      grdServicos.Cells[0, Cont + 1] := IntToStr(TServico(Lista[Cont]).Id);
      grdServicos.Cells[1, Cont + 1] := TServico(Lista[Cont]).Farmaceutico.Nome;
      grdServicos.Cells[2, Cont + 1] := TServico(Lista[Cont]).Paciente.Nome;
      grdServicos.Cells[3, Cont + 1] := TServico(Lista[Cont]).Observacoes.Text;
      grdServicos.Cells[4, Cont + 1] := FormatCurr(',0.00', TServico(Lista[Cont]).ValorTotal);
    end;
  finally
    FreeAndNil(ControleServico);
    FreeAndNil(Lista);
  end;
  if grdServicos.RowCount = 1 then
    grdServicos.RowCount := 2;
  grdServicos.FixedRows := 1;
end;

procedure TfrmPrincipal.SpeedButton4Click(Sender: TObject);
begin
  Close;
end;

end.
