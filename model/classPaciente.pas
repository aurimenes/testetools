unit classPaciente;

interface

uses Classe, SysUtils, System.Classes;

type
  TPaciente = class(TClasse)
  private
    FNome: String;
    procedure SetNome(const Value: String);
  public
    property Nome: String read FNome write SetNome;
  end;

implementation

{ TPaciente }

uses uDM;

procedure TPaciente.SetNome(const Value: String);
begin
  FNome := Value;
end;

end.
