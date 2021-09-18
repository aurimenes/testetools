unit classPacientes;

interface

type
  TPaciente = class
  private
    Fid: Integer;
    FNome: String;
    procedure SetNome(const Value: String);
  public
    property Id: Integer read Fid;
    property Nome: String read FNome write SetNome;
  end;

implementation

{ TPaciente }

procedure TPaciente.SetNome(const Value: String);
begin
  FNome := Value;
end;

end.
