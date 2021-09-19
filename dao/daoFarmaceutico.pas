unit daoFarmaceutico;

interface

uses Classe, Dao, classFarmaceutico, System.Classes;

type
  TDaoFarmaceutico = class(TDao)
  private
  public
    procedure Gravar(Classe: TClasse); Override;
    procedure Excluir(AId: Integer); Override;
    function Carregar(AId: Integer): TClasse; Override;
    procedure Listar(ALista: TList);
  end;

implementation

{ TDaoFarmaceutico }

function TDaoFarmaceutico.Carregar(AId: Integer): TClasse;
begin
  Result := TFarmaceutico.Create;

  try
    qryConsulta.Close;
    qryConsulta.SQL.Add('select far_nome from farmaceuticos');
    qryConsulta.SQL.Add('where far_id = :far_id');
    qryConsulta.ParamByName('far_id').AsInteger := AId;
    qryConsulta.Open;

    if qryConsulta.IsEmpty then
    begin
      Result.Id := -1;
      TFarmaceutico(Result).Nome := '';
    end
    else
    begin
      Result.Id := AId;
      TFarmaceutico(Result).Nome := qryConsulta.FieldByName('far_nome').AsString;
    end;
  finally
    qryConsulta.Free
  end;
end;

procedure TDaoFarmaceutico.Excluir(AId: Integer);
begin
  inherited;

  qryConsulta.Close;
  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('delete from farmaceuticos');
  qryConsulta.SQL.Add('where far_id = :far_id');
  qryConsulta.ParamByName('far_id').AsInteger := AId;
  qryConsulta.ExecSQL;
end;

procedure TDaoFarmaceutico.Gravar(Classe: TClasse);
begin
  try
    if Classe.Id = 0 then
    begin
      qryConsulta.SQL.Add('insert into farmaceuticos (far_nome)');
      qryConsulta.SQL.Add('values (:far_nome)');
      qryConsulta.ParamByName('far_nome').AsString := TFarmaceutico(Classe).Nome;
      qryConsulta.ExecSQL;

      qryConsulta.SQL.Clear;
      qryConsulta.SQL.Add('select last_insert_id() as id');
      qryConsulta.Open;

      Classe.Id := qryConsulta.FieldByName('id').AsInteger;
    end
    else
    begin
      qryConsulta.SQL.Add('update farmaceuticos');
      qryConsulta.SQL.Add('set far_nome = :far_nome');
      qryConsulta.SQL.Add('where far_id = :far_id');
      qryConsulta.ParamByName('far_id').AsInteger := Classe.Id;
      qryConsulta.ParamByName('far_nome').AsString := TFarmaceutico(Classe).Nome;
      qryConsulta.ExecSQL;
    end;
  finally
    qryConsulta.Free;
  end;
end;

procedure TDaoFarmaceutico.Listar(ALista: TList);
var
  Farmac: TFarmaceutico;
begin
  inherited;

  qryConsulta.Close;
  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('select far_id, far_nome from farmaceuticos');
  qryConsulta.SQL.Add('order by far_nome');
  qryConsulta.Open;

  while not qryConsulta.Eof do
  begin
    Farmac := TFarmaceutico.Create;
    Farmac.Id := qryConsulta.FieldByName('far_id').AsInteger;
    Farmac.Nome := qryConsulta.FieldByName('far_nome').AsString;
    ALista.Add(Farmac);
    qryConsulta.Next;
  end;
end;

end.
