unit dao;

interface

uses System.Classes, Classe, SysUtils, FireDAC.Comp.Client;

type
  TDao = class
  protected
    qryConsulta: TFDQuery;
  private
    FLista: TList;
  public
    constructor Create(DB: TFDConnection);
    destructor Destroy;
    procedure Gravar(Classe: TClasse); Virtual; Abstract;
    function Carregar(AId: Integer): TClasse; Virtual; Abstract;
    procedure Listar(var ALista: TList); 
  end;

implementation

{ TDao }

constructor TDao.Create(DB: TFDConnection);
begin
  if not Assigned(DB) then
    raise Exception.Create('Conexão não informada!');

  FLista := TList.Create;

  qryConsulta := TFDQuery.Create(Nil);
  qryConsulta.Connection := DB;
  qryConsulta.Transaction := DB.Transaction;
end;

destructor TDao.Destroy;
begin
  qryConsulta.Free;
  FLista.Free;
end;

procedure TDao.Listar(var ALista: TList);
var
  Cont: Integer;
begin
  if not Assigned(ALista) then
    raise Exception.Create('Lista deve ser criada!');

  if (ALista.Count > 0) then // Limpa a lista, se já possuir objetos
  begin
    for Cont := 0 to ALista.Count - 1 do
    begin
      TClasse(ALista[Cont]).Free;
    end;
  end;
end;

end.
