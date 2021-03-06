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
    procedure Excluir(AId: Integer); Virtual; Abstract;
    function Carregar(AId: Integer): TClasse; Virtual; Abstract;
    procedure Listar(ALista: TList);
  end;

implementation

{ TDao }

constructor TDao.Create(DB: TFDConnection);
begin
  if not Assigned(DB) then
    raise Exception.Create('Conex?o n?o informada!');

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

procedure TDao.Listar(ALista: TList);
var
  Cont: Integer;
begin
  if not Assigned(ALista) then
    raise Exception.Create('Lista deve ser criada!');

//  if (ALista.Count > 0) then // Limpa a lista, se j? possuir objetos
//  begin
//    for Cont := ALista.Count - 1 downto 0 do
//    begin
//      TClasse(ALista[Cont]).Free;
//    end;
//  end;

  ALista.Clear;
end;

end.
