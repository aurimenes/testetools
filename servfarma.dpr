program servfarma;

uses
  Vcl.Forms,
  u_frmPrincipal in 'view\u_frmPrincipal.pas' {frmPrincipal},
  classServicos in 'model\classServicos.pas',
  classFarmaceutico in 'model\classFarmaceutico.pas',
  classPacientes in 'model\classPacientes.pas',
  uDM in 'uDM.pas' {DM: TDataModule},
  daoFarmaceutico in 'dao\daoFarmaceutico.pas',
  dao in 'dao\dao.pas',
  classe in 'model\classe.pas',
  controlFarmaceutico in 'controller\controlFarmaceutico.pas',
  controle in 'controller\controle.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Serviços Farmacêuticos';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
