unit classServicoItem;

interface

uses Classe, SysUtils, System.Classes, classTipo;

type
  TServicoItem = class(TClasse)
  private
    FTipo: TTipo;
    FValor: Currency;
  public
    constructor Create;
    destructor Destroy;
    property Tipo: TTipo read FTipo write FTipo;
    property Valor: Currency read FValor write FValor;
  end;

implementation

{ TServicos }

{ TServicoItem }

{ TServicoItem }

constructor TServicoItem.Create;
begin
  Tipo := TTipo.Create;
end;

destructor TServicoItem.Destroy;
begin
  Tipo.Free;
end;

end.
