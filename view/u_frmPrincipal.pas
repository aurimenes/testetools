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
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
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
  frmCadServico.ShowModal;
  FreeAndNil(frmCadServico);

  CarregaGrid;
end;

procedure TfrmPrincipal.SpeedButton2Click(Sender: TObject);
begin
  { TODO : Validar se existe registro selecionado no grid (grid vazio?) }
  frmCadServico := TfrmCadServico.Create(Self);
  frmCadServico.Servico.Id := StrToInt(grdServicos.Cells[0, grdServicos.Row]); // Serviço Existente
  frmCadServico.ShowModal;
  FreeAndNil(frmCadServico);

  CarregaGrid;
end;

procedure TfrmPrincipal.SpeedButton3Click(Sender: TObject);
var
  ControleServico: TControlServico;
begin
  { TODO : Validar se existe registro selecionado no grid (grid vazio?) }
  { TODO : Quando exclui o último item, o grid continua mostrando o item, mesmo não existindo mais }
  if Application.MessageBox('Confirma a exclusão do item selecionado?', 'Excluir item', MB_YESNO + MB_ICONWARNING) = IDYES then
  begin
    ControleServico := TControlServico.Create(DM.DB);

    try
      ControleServico.Excluir(StrToInt(grdServicos.Cells[0, grdServicos.Row]));
      CarregaGrid;
    finally
      FreeAndNil(ControleServico);
    end;
  end;
end;

procedure TfrmPrincipal.CarregaGrid;
var
  Lista: TList;
  ControleServico: TControlServico;
  Cont: Integer;
begin
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

  Lista := TList.Create;
  ControleServico := TControlServico.Create(DM.DB);

  try
    ControleServico.Listar(Lista);
    grdServicos.RowCount := Lista.Count + 1;
    grdServicos.ColCount := 5;

    for Cont := 0 to Lista.Count - 1 do
    begin

      grdServicos.Cells[0, Cont + 1] := IntToStr(TServico(Lista[Cont]).Id);
      grdServicos.Cells[1, Cont + 1] := TServico(Lista[Cont]).Farmaceutico.Nome;
      grdServicos.Cells[2, Cont + 1] := TServico(Lista[Cont]).Paciente.Nome;

      if (TServico(Lista[Cont]).Observacoes.Count > 0) then
        grdServicos.Cells[3, Cont + 1] := TServico(Lista[Cont]).Observacoes[0];

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

procedure TfrmPrincipal.SpeedButton5Click(Sender: TObject);
begin
  Application.MessageBox('Desculpe, esta função está em desenvolvimento!', 'Em desenvolvimento...', MB_OK);
end;

procedure TfrmPrincipal.SpeedButton6Click(Sender: TObject);
begin
  Application.MessageBox('Desculpe, esta função está em desenvolvimento!', 'Em desenvolvimento...', MB_OK);
end;

procedure TfrmPrincipal.SpeedButton7Click(Sender: TObject);
begin
  Application.MessageBox('Desculpe, esta função está em desenvolvimento!', 'Em desenvolvimento...', MB_OK);
end;

end.
