unit classServicoItem;

interface

uses Classe, SysUtils, System.Classes, classTipo;

type
  TServicoItem = class(TClasse)
  private
    FTipo: TTipo;
    FValor: Currency;
  public
    property Tipo: TTipo read FTipo write FTipo;
    property Valor: Currency read FValor write FValor;
  end;

implementation

{ TServicos }

{ TServicoItem }

end.
