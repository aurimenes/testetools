unit controlFarmaceutico;

interface

uses Controle, Classe, DaoFarmaceutico, FireDAC.Comp.Client, SysUtils,
  classFarmaceutico, System.Classes;

type TControlFarmaceutico = class(TControle)
  private
    FDao: TDaoFarmaceutico;
  public
    constructor Create(DB: TFDConnection);
    destructor Destroy;
    procedure Gravar(Classe: TClasse); override;
    procedure Excluir(AId: Integer); override;
    function Carregar(AId: Integer): TClasse;
    procedure Listar(var ALista: TList);
end;

implementation

{ TControlFarmaceutico }

function TControlFarmaceutico.Carregar(AId: Integer): TClasse;
begin
  inherited;

  Result := FDao.Carregar(AId)
end;

constructor TControlFarmaceutico.Create(DB: TFDConnection);
begin
  inherited;

  FDao := TDaoFarmaceutico.Create(DB);
end;

destructor TControlFarmaceutico.Destroy;
begin
  FDao.Free;
end;

procedure TControlFarmaceutico.Excluir(AId: Integer);
begin
  inherited;

  FDao.Excluir(AId);
end;

procedure TControlFarmaceutico.Gravar(Classe: TClasse);
begin
  inherited;

  if Classe.Id = -1 then
    raise Exception.Create('Farmacêutico Inexistente!');

  if TFarmaceutico(Classe).Nome = '' then
    raise Exception.Create('Informe o nome do Farmacêutico!');

  FDao.Gravar(Classe);
end;

procedure TControlFarmaceutico.Listar(var ALista: TList);
begin
  FDao.Listar(ALista);
end;

end.
