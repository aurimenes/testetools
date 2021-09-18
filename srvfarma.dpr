program srvfarma;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmPrincipal in 'view\frmPrincipal.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
