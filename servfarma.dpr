program servfarma;

uses
  Vcl.Forms,
  u_frmPrincipal in 'view\u_frmPrincipal.pas' {frmPrincipal},
  classServico in 'model\classServico.pas',
  classFarmaceutico in 'model\classFarmaceutico.pas',
  classPaciente in 'model\classPaciente.pas',
  uDM in 'uDM.pas' {DM: TDataModule},
  daoFarmaceutico in 'dao\daoFarmaceutico.pas',
  dao in 'dao\dao.pas',
  classe in 'model\classe.pas',
  controlFarmaceutico in 'controller\controlFarmaceutico.pas',
  controle in 'controller\controle.pas',
  controlPaciente in 'controller\controlPaciente.pas',
  daoPaciente in 'dao\daoPaciente.pas',
  daoTipo in 'dao\daoTipo.pas',
  classTipo in 'model\classTipo.pas',
  controlTipo in 'controller\controlTipo.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Serviços Farmacêuticos';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
