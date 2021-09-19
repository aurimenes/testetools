unit controle;

interface

uses System.Classes, Classe, SysUtils, FireDAC.Comp.Client;

type TControle = Class
  private
  public
    constructor Create(DB: TFDConnection); virtual; abstract;
    destructor Destroy; virtual; abstract;
    procedure Gravar(Classe: TClasse); virtual; abstract;
    procedure Excluir(AId: Integer); Virtual; Abstract;
    function Carregar(AId: Integer): TClasse; virtual; abstract;
    procedure Listar(var ALista: TList); virtual; abstract;
End;

implementation

{ TControle }

end.
