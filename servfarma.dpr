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
  controlTipo in 'controller\controlTipo.pas',
  daoServico in 'dao\daoServico.pas',
  controlServico in 'controller\controlServico.pas',
  u_frmCadServico in 'view\u_frmCadServico.pas' {frmCadServico},
  classServicoItem in 'model\classServicoItem.pas',
  u_frmSelecionaTipo in 'view\u_frmSelecionaTipo.pas' {frmSelecionaTipo};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Servi?os Farmac?uticos';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
