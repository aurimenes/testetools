unit controlTipo;

interface

uses Controle, Classe, DaoTipo, FireDAC.Comp.Client, SysUtils,
  classTipo, System.Classes;

type TControlTipo = class(TControle)
  private
    FDao: TDaoTipo;
  public
    constructor Create(DB: TFDConnection);
    destructor Destroy;
    procedure Gravar(Classe: TClasse); override;
    procedure Excluir(AId: Integer); override;
    function Carregar(AId: Integer): TClasse;
    procedure Listar(var ALista: TList);
end;

implementation

{ TControlTipo }

function TControlTipo.Carregar(AId: Integer): TClasse;
begin
  inherited;

  Result := FDao.Carregar(AId)
end;

constructor TControlTipo.Create(DB: TFDConnection);
begin
  inherited;

  FDao := TDaoTipo.Create(DB);
end;

destructor TControlTipo.Destroy;
begin
  FDao.Free;
end;

procedure TControlTipo.Excluir(AId: Integer);
begin
  inherited;

  FDao.Excluir(AId);
end;

procedure TControlTipo.Gravar(Classe: TClasse);
begin
  inherited;

  if Classe.Id = -1 then
    raise Exception.Create('Tipo de Serviço Inexistente!');

  if TTipo(Classe).Descricao = '' then
    raise Exception.Create('Informe a descrição do Tipo de Serviço!');

  if TTipo(Classe).ValorUnit = 0 then
    raise Exception.Create('Informe o valor do Tipo de Serviço!');

  FDao.Gravar(Classe);
end;

procedure TControlTipo.Listar(var ALista: TList);
begin
  FDao.Listar(ALista);
end;

end.
