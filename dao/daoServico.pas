unit daoServico;

interface

uses Classe, Dao, classServico, System.Classes, FireDAC.Comp.Client;

type
  TDaoServico = class(TDao)
  private
  public
    procedure Gravar(Classe: TClasse); Override;
    procedure Excluir(AId: Integer); Override;
    function Carregar(AId: Integer): TClasse; Override;
    procedure Listar(ALista: TList);
  end;

implementation

{ TDaoServico }

uses daoFarmaceutico, classFarmaceutico, daoPaciente, classPaciente;

function TDaoServico.Carregar(AId: Integer): TClasse;
var
  DaoFarmaceutico: TDaoFarmaceutico;
  DaoPaciente: TDaoPaciente;
begin
  Result := TServico.Create;
  DaoFarmaceutico := TDaoFarmaceutico.Create(TFDConnection(qryConsulta.Connection));
  DaoPaciente := TDaoPaciente.Create(TFDConnection(qryConsulta.Connection));

  try
    qryConsulta.Close;
    qryConsulta.SQL.Add('select far_id_fk, pac_id_fk, ser_obs, ser_valor_total from servicos');
    qryConsulta.SQL.Add('where ser_id = :ser_id');
    qryConsulta.ParamByName('ser_id').AsInteger := AId;
    qryConsulta.Open;

    if qryConsulta.IsEmpty then
    begin
      Result.Id := -1;
      TServico(Result).Farmaceutico.Id := -1;
      TServico(Result).Farmaceutico.Nome := '';
      TServico(Result).Paciente.Id := -1;
      TServico(Result).Paciente.Nome := '';
      TServico(Result).Observacoes.Clear;
      TServico(Result).ValorTotal := 0;
    end
    else
    begin
      Result.Id := AId;
      TServico(Result).Farmaceutico := TFarmaceutico(DaoFarmaceutico.Carregar(qryConsulta.FieldByName('far_id_fk').AsInteger));
      TServico(Result).Paciente := TPaciente(DaoPaciente.Carregar(qryConsulta.FieldByName('pac_id_fk').AsInteger));
      TServico(Result).Observacoes.Text := qryConsulta.FieldByName('ser_obs').AsString;
      TServico(Result).ValorTotal := qryConsulta.FieldByName('ser_valor_total').AsCurrency;
    end;
  finally
    DaoFarmaceutico.Free;
    qryConsulta.Free
  end;
end;

procedure TDaoServico.Excluir(AId: Integer);
begin
  inherited;

  qryConsulta.Close;
  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('delete from servicos');
  qryConsulta.SQL.Add('where ser_id = :ser_id');
  qryConsulta.ParamByName('ser_id').AsInteger := AId;
  qryConsulta.ExecSQL;
end;

procedure TDaoServico.Gravar(Classe: TClasse);
begin
  try
    if Classe.Id = 0 then
    begin
      qryConsulta.SQL.Add('insert into servicos (far_id_fk, pac_id_fk, ser_obs, ser_valor_total)');
      qryConsulta.SQL.Add('values (:far_id_fk, :pac_id_fk, :ser_obs, :ser_valor_total)');
      qryConsulta.ParamByName('far_id_fk').AsInteger := TServico(Classe).Farmaceutico.Id;
      qryConsulta.ParamByName('pac_id_fk').AsInteger := TServico(Classe).Paciente.Id;
      qryConsulta.ParamByName('ser_obs').AsString := TServico(Classe).Observacoes.Text;
      qryConsulta.ParamByName('ser_valor_total').AsCurrency := TServico(Classe).ValorTotal;
      qryConsulta.ExecSQL;

      qryConsulta.SQL.Clear;
      qryConsulta.SQL.Add('select last_insert_id() as id');
      qryConsulta.Open;

      Classe.Id := qryConsulta.FieldByName('id').AsInteger;
    end
    else
    begin
      qryConsulta.SQL.Add('update servicos');
      qryConsulta.SQL.Add('set far_id_fk = :far_id_fk, pac_id_fk = :pac_id_fk,');
      qryConsulta.SQL.Add('  ser_obs = :ser_obs, ser_valor_total = :ser_valor_total');
      qryConsulta.SQL.Add('where ser_id = :ser_id');
      qryConsulta.ParamByName('far_id_fk').AsInteger := TServico(Classe).Farmaceutico.Id;
      qryConsulta.ParamByName('pac_id_fk').AsInteger := TServico(Classe).Paciente.Id;
      qryConsulta.ParamByName('ser_obs').AsString := TServico(Classe).Observacoes.Text;
      qryConsulta.ParamByName('ser_valor_total').AsCurrency := TServico(Classe).ValorTotal;
      qryConsulta.ParamByName('ser_id').AsInteger := Classe.Id;
      qryConsulta.ExecSQL;
    end;
  finally
    qryConsulta.Free;
  end;
end;

procedure TDaoServico.Listar(ALista: TList);
var
  Servico: TServico;
begin
  inherited;

  qryConsulta.Close;
  qryConsulta.SQL.Clear;
  QryConsulta.SQL.Add('select ser_id, far_id, far_nome, pac_id, pac_nome, ser_obs, ser_valor_total');
  QryConsulta.SQL.Add('from servicos');
  QryConsulta.SQL.Add('inner join farmaceuticos ON (far_id = far_id_fk)');
  QryConsulta.SQL.Add('inner join pacientes ON (pac_id = pac_id_fk)');
  QryConsulta.SQL.Add('order by ser_id desc');

  qryConsulta.Open;

  while not qryConsulta.Eof do
  begin
    Servico := TServico.Create;
    Servico.Id := qryConsulta.FieldByName('ser_id').AsInteger;
    Servico.Farmaceutico.Id := qryConsulta.FieldByName('far_id').AsInteger;
    Servico.Farmaceutico.Nome := qryConsulta.FieldByName('far_nome').AsString;
    Servico.Paciente.Id := qryConsulta.FieldByName('pac_id').AsInteger;
    Servico.Paciente.Nome := qryConsulta.FieldByName('pac_nome').AsString;
    Servico.Observacoes.Text := qryConsulta.FieldByName('ser_obs').AsString;
    Servico.ValorTotal := qryConsulta.FieldByName('ser_valor_total').AsCurrency;
    ALista.Add(Servico);
    qryConsulta.Next;
  end;
end;

end.
