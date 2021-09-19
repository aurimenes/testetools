unit daoTipo;

interface

uses Classe, Dao, classTipo, System.Classes;

type
  TDaoTipo = class(TDao)
  private
  public
    procedure Gravar(Classe: TClasse); Override;
    procedure Excluir(AId: Integer); Override;
    function Carregar(AId: Integer): TClasse; Override;
    procedure Listar(ALista: TList);
  end;

implementation

{ TDaoTipo }

function TDaoTipo.Carregar(AId: Integer): TClasse;
begin
  Result := TTipo.Create;

  try
    qryConsulta.Close;
    qryConsulta.SQL.Add('select tip_descricao, tip_valor from tipos');
    qryConsulta.SQL.Add('where tip_id = :tip_id');
    qryConsulta.ParamByName('tip_id').AsInteger := AId;
    qryConsulta.Open;

    if qryConsulta.IsEmpty then
    begin
      Result.Id := -1;
      TTipo(Result).Descricao := '';
      TTipo(Result).ValorUnit := 0;
    end
    else
    begin
      Result.Id := AId;
      TTipo(Result).Descricao := qryConsulta.FieldByName('tip_nome').AsString;
      TTipo(Result).ValorUnit := qryConsulta.FieldByName('tip_valor').AsCurrency;
    end;
  finally
    qryConsulta.Free
  end;
end;

procedure TDaoTipo.Excluir(AId: Integer);
begin
  inherited;

  qryConsulta.Close;
  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('delete from tipos');
  qryConsulta.SQL.Add('where tip_id = :tip_id');
  qryConsulta.ParamByName('tip_id').AsInteger := AId;
  qryConsulta.ExecSQL;
end;

procedure TDaoTipo.Gravar(Classe: TClasse);
begin
  try
    if Classe.Id = 0 then
    begin
      qryConsulta.SQL.Add('insert into tipos (tip_descricao, tip_valor)');
      qryConsulta.SQL.Add('values (:tip_descricao, :tip_valor)');
      qryConsulta.ParamByName('tip_descricao').AsString := TTipo(Classe).Descricao;
      qryConsulta.ParamByName('tip_valor').AsCurrency := TTipo(Classe).ValorUnit;
      qryConsulta.ExecSQL;

      qryConsulta.SQL.Clear;
      qryConsulta.SQL.Add('select last_insert_id() as id');
      qryConsulta.Open;

      Classe.Id := qryConsulta.FieldByName('id').AsInteger;
    end
    else
    begin
      qryConsulta.SQL.Add('update tipos');
      qryConsulta.SQL.Add('set tip_descricao = :tip_descricao, tip_valor = :tip_valor');
      qryConsulta.SQL.Add('where tip_id = :tip_id');
      qryConsulta.ParamByName('tip_id').AsInteger := Classe.Id;
      qryConsulta.ParamByName('tip_descricao').AsString := TTipo(Classe).Descricao;
      qryConsulta.ParamByName('tip_valor').AsCurrency := TTipo(Classe).ValorUnit;
      qryConsulta.ExecSQL;
    end;
  finally
    qryConsulta.Free;
  end;
end;

procedure TDaoTipo.Listar(ALista: TList);
var
  Tipo: TTipo;
begin
  inherited;

  qryConsulta.Close;
  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('select tip_id, tip_descricao, tip_valor from tipos');
  qryConsulta.SQL.Add('order by tip_descricao');
  qryConsulta.Open;

  while not qryConsulta.Eof do
  begin
    Tipo := TTipo.Create;
    Tipo.Id := qryConsulta.FieldByName('tip_id').AsInteger;
    Tipo.Descricao := qryConsulta.FieldByName('tip_descricao').AsString;
    Tipo.ValorUnit := qryConsulta.FieldByName('tip_valor').AsCurrency;
    ALista.Add(Tipo);
    qryConsulta.Next;
  end;
end;

end.
