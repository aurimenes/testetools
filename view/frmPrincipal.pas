unit frmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls, Vcl.Buttons;

type
  TForm1 = class(TForm)
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
  Form1: TForm1;

implementation

{$R *.dfm}

uses classServicos, classFarmaceutico;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  Farmac: TFarmaceutico;
begin
  Farmac := TFarmaceutico.Create;
  Farmac.Carregar(1);
  ShowMessage(Farmac.Nome);

  FreeAndNil(Farmac);
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  Close;
end;

end.
