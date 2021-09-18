unit u_frmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmPrincipal = class(TForm)
    Panel1: TPanel;
    StringGrid1: TStringGrid;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses classFarmaceutico, uDM, controlFarmaceutico;

procedure TfrmPrincipal.SpeedButton1Click(Sender: TObject);
var
  ContFarmac: TControlFarmaceutico;
  Lista: TList;
begin
  ContFarmac := TControlFarmaceutico.Create(DM.DB);
  Lista := TList.Create;
  ContFarmac.Listar(Lista);
  FreeAndNil(Lista);
  FreeAndNil(ContFarmac);
end;

procedure TfrmPrincipal.SpeedButton4Click(Sender: TObject);
begin
  Close;
end;

end.
