unit controlServico;

interface

uses Controle, Classe, DaoServico, FireDAC.Comp.Client, SysUtils,
  classServico, System.Classes;

type TControlServico = class(TControle)
  private
    FDao: TDaoServico;
  public
    constructor Create(DB: TFDConnection);
    destructor Destroy;
    procedure Gravar(Classe: TClasse); override;
    procedure Excluir(AId: Integer); override;
    function Carregar(AId: Integer): TClasse;
    procedure Listar(var ALista: TList);
end;

implementation

{ TControlServico }

function TControlServico.Carregar(AId: Integer): TClasse;
begin
  inherited;

  Result := FDao.Carregar(AId);
end;

constructor TControlServico.Create(DB: TFDConnection);
begin
  inherited;

  FDao := TDaoServico.Create(DB);
end;

destructor TControlServico.Destroy;
begin
  FDao.Free;
end;

procedure TControlServico.Excluir(AId: Integer);
begin
  inherited;

  FDao.Excluir(AId);
end;

procedure TControlServico.Gravar(Classe: TClasse);
begin
  inherited;

  if Classe.Id = -1 then
    raise Exception.Create('Serviço Inexistente!');

//  if TServico(Classe).Nome = '' then
//    raise Exception.Create('Informe o nome do Farmacêutico!');

  FDao.Gravar(Classe);
end;

procedure TControlServico.Listar(var ALista: TList);
begin
  FDao.Listar(ALista);
end;

end.
