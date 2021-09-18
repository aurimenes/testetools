program servfarma;

uses
  Vcl.Forms,
  frmPrincipal in 'view\frmPrincipal.pas' {Form1},
  classServicos in 'model\classServicos.pas',
  classFarmaceutico in 'model\classFarmaceutico.pas',
  classPacientes in 'model\classPacientes.pas',
  uDM in 'uDM.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Servi�os Farmac�uticos';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
