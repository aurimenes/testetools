unit controlPaciente;

interface

uses Controle, Classe, DaoPaciente, FireDAC.Comp.Client, SysUtils,
  classPaciente, System.Classes;

type TControlPaciente = class(TControle)
  private
    FDao: TDaoPaciente;
  public
    constructor Create(DB: TFDConnection);
    destructor Destroy;
    procedure Gravar(Classe: TClasse); override;
    procedure Excluir(AId: Integer); override;
    function Carregar(AId: Integer): TClasse;
    procedure Listar(var ALista: TList);
end;

implementation

{ TControlPaciente }

function TControlPaciente.Carregar(AId: Integer): TClasse;
begin
  inherited;

  Result := FDao.Carregar(AId)
end;

constructor TControlPaciente.Create(DB: TFDConnection);
begin
  inherited;

  FDao := TDaoPaciente.Create(DB);
end;

destructor TControlPaciente.Destroy;
begin
  FDao.Free;
end;

procedure TControlPaciente.Excluir(AId: Integer);
begin
  inherited;

  FDao.Excluir(AId);
end;

procedure TControlPaciente.Gravar(Classe: TClasse);
begin
  inherited;

  if Classe.Id = -1 then
    raise Exception.Create('Paciente Inexistente!');

  if TPaciente(Classe).Nome = '' then
    raise Exception.Create('Informe o nome do Paciente!');

  FDao.Gravar(Classe);
end;

procedure TControlPaciente.Listar(var ALista: TList);
begin
  FDao.Listar(ALista);
end;

end.
