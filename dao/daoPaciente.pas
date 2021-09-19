unit daoPaciente;

interface

uses Classe, Dao, classPaciente, System.Classes;

type
  TDaoPaciente = class(TDao)
  private
  public
    procedure Gravar(Classe: TClasse); Override;
    procedure Excluir(AId: Integer); Override;
    function Carregar(AId: Integer): TClasse; Override;
    procedure Listar(ALista: TList);
  end;

implementation

{ TDaoPaciente }

function TDaoPaciente.Carregar(AId: Integer): TClasse;
begin
  Result := TPaciente.Create;

  try
    qryConsulta.Close;
    qryConsulta.SQL.Add('select pac_nome from pacientes');
    qryConsulta.SQL.Add('where pac_id = :pac_id');
    qryConsulta.ParamByName('pac_id').AsInteger := AId;
    qryConsulta.Open;

    if qryConsulta.IsEmpty then
    begin
      Result.Id := -1;
      TPaciente(Result).Nome := '';
    end
    else
    begin
      Result.Id := AId;
      TPaciente(Result).Nome := qryConsulta.FieldByName('pac_nome').AsString;
    end;
  finally
    qryConsulta.Free
  end;
end;

procedure TDaoPaciente.Excluir(AId: Integer);
begin
  inherited;

  qryConsulta.Close;
  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('delete from pacientes');
  qryConsulta.SQL.Add('where pac_id = :pac_id');
  qryConsulta.ParamByName('pac_id').AsInteger := AId;
  qryConsulta.ExecSQL;
end;

procedure TDaoPaciente.Gravar(Classe: TClasse);
begin
  try
    if Classe.Id = 0 then
    begin
      qryConsulta.SQL.Add('insert into pacientes (pac_nome)');
      qryConsulta.SQL.Add('values (:pac_nome)');
      qryConsulta.ParamByName('pac_nome').AsString := TPaciente(Classe).Nome;
      qryConsulta.ExecSQL;

      qryConsulta.SQL.Clear;
      qryConsulta.SQL.Add('select last_insert_id() as id');
      qryConsulta.Open;

      Classe.Id := qryConsulta.FieldByName('id').AsInteger;
    end
    else
    begin
      qryConsulta.SQL.Add('update pacientes');
      qryConsulta.SQL.Add('set pac_nome = :pac_nome');
      qryConsulta.SQL.Add('where pac_id = :pac_id');
      qryConsulta.ParamByName('pac_id').AsInteger := Classe.Id;
      qryConsulta.ParamByName('pac_nome').AsString := TPaciente(Classe).Nome;
      qryConsulta.ExecSQL;
    end;
  finally
    qryConsulta.Free;
  end;
end;

procedure TDaoPaciente.Listar(ALista: TList);
var
  Farmac: TPaciente;
begin
  inherited;

  qryConsulta.Close;
  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('select pac_id, pac_nome from pacientes');
  qryConsulta.SQL.Add('order by pac_nome');
  qryConsulta.Open;

  while not qryConsulta.Eof do
  begin
    Farmac := TPaciente.Create;
    Farmac.Id := qryConsulta.FieldByName('pac_id').AsInteger;
    Farmac.Nome := qryConsulta.FieldByName('pac_nome').AsString;
    ALista.Add(Farmac);
    qryConsulta.Next;
  end;
end;

end.
