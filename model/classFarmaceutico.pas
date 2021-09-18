unit classFarmaceutico;

interface

uses Classe, SysUtils, System.Classes;

type
  TFarmaceutico = class(TClasse)
  private
    FNome: String;
    FLista: TList;
    procedure SetNome(const Value: String);
  public
    property Nome: String read FNome write SetNome;
  end;

implementation

{ TFarmaceutico }

uses uDM;

procedure TFarmaceutico.SetNome(const Value: String);
begin
  FNome := Value;
end;

end.
