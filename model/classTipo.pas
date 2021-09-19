unit classTipo;

interface

uses Classe, SysUtils, System.Classes;

type
  TTipo = class(TClasse)
  private
    FDescricao: String;
    FValorUnit: Currency;
    procedure SetDescricao(const Value: String);
    procedure SetValorUnit(const Value: Currency);
  public
    property Descricao: String read FDescricao write SetDescricao;
    property ValorUnit: Currency read FValorUnit write SetValorUnit;
  end;

implementation

{ TTipo }

uses uDM;

procedure TTipo.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TTipo.SetValorUnit(const Value: Currency);
begin
  FValorUnit := Value;
end;

end.
