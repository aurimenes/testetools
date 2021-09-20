unit daoServico;

interface

uses Classe, Dao, classServico, classServicoItem, System.Classes, FireDAC.Comp.Client;

type
  TDaoServico = class(TDao)
  private
    qryAux: TFDQuery;
  public
    constructor Create(DB: TFDConnection);
    destructor Destroy;
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
  ItemServico: TServicoItem;
begin
  Result := TServico.Create;
  DaoFarmaceutico := TDaoFarmaceutico.Create(TFDConnection(qryConsulta.Connection));
  DaoPaciente := TDaoPaciente.Create(TFDConnection(qryConsulta.Connection));

  TServico(Result).LimpaItens;

  try
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('select far_id_fk, pac_id_fk, ser_obs, ser_valor_total from servicos');
    qryConsulta.SQL.Add('where ser_id = :ser_id');
    qryConsulta.ParamByName('ser_id').AsInteger := AId;
    qryConsulta.Open;

    if qryConsulta.IsEmpty then
    begin
      TServico(Result).Id := -1;
      TServico(Result).Farmaceutico.Id := -1;
      TServico(Result).Farmaceutico.Nome := '';
      TServico(Result).Paciente.Id := -1;
      TServico(Result).Paciente.Nome := '';
      TServico(Result).Observacoes.Clear;
      TServico(Result).ValorTotal := 0;
    end
    else
    begin
      TServico(Result).Id := AId;
      TServico(Result).Farmaceutico := TFarmaceutico(DaoFarmaceutico.Carregar(qryConsulta.FieldByName('far_id_fk').AsInteger));
      TServico(Result).Paciente := TPaciente(DaoPaciente.Carregar(qryConsulta.FieldByName('pac_id_fk').AsInteger));
      TServico(Result).Observacoes.Text := qryConsulta.FieldByName('ser_obs').AsString;
//      TServico(Result).ValorTotal := qryConsulta.FieldByName('ser_valor_total').AsCurrency; -- Valor total somado nos itens

      qryConsulta.Close;
      qryConsulta.SQL.Clear;
      qryConsulta.SQL.Add('select sit_id, tip_id_fk, sit_valor, tip_descricao from servicos_itens');
      qryConsulta.SQL.Add('inner join tipos on (tip_id = tip_id_fk)');
      qryConsulta.SQL.Add('where ser_id_fk = :ser_id_fk');
      qryConsulta.ParamByName('ser_id_fk').AsInteger := AId;
      qryConsulta.Open;

      while not qryConsulta.eof do
      begin
        ItemServico := TServicoItem.Create;
        ItemServico.Id := qryConsulta.FieldByName('sit_id').AsInteger;
        ItemServico.Tipo.Id := qryConsulta.FieldByName('tip_id_fk').AsInteger;
        ItemServico.Tipo.Descricao := qryConsulta.FieldByName('tip_descricao').AsString;
        ItemServico.Valor := qryConsulta.FieldByName('sit_valor').AsCurrency;
        TServico(Result).AdicionaItem(ItemServico);

        qryConsulta.Next;
      end;
    end;
  finally
    DaoFarmaceutico.Free;
  end;
end;

constructor TDaoServico.Create(DB: TFDConnection);
begin
  inherited;

  qryAux := TFDQuery.Create(nil);
  qryAux.Connection := DB;
  qryAux.Transaction := DB.Transaction;
end;

destructor TDaoServico.Destroy;
begin
  inherited;

  qryConsulta.Free;
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
var
  Cont: Integer;
begin
  if TServico(Classe).Id = 0 then
  begin
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
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

    TServico(Classe).Id := qryConsulta.FieldByName('id').AsInteger;
  end
  else
  begin
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('update servicos');
    qryConsulta.SQL.Add('set far_id_fk = :far_id_fk, pac_id_fk = :pac_id_fk,');
    qryConsulta.SQL.Add('  ser_obs = :ser_obs, ser_valor_total = :ser_valor_total');
    qryConsulta.SQL.Add('where ser_id = :ser_id');
    qryConsulta.ParamByName('far_id_fk').AsInteger := TServico(Classe).Farmaceutico.Id;
    qryConsulta.ParamByName('pac_id_fk').AsInteger := TServico(Classe).Paciente.Id;
    qryConsulta.ParamByName('ser_obs').AsString := TServico(Classe).Observacoes.Text;
    qryConsulta.ParamByName('ser_valor_total').AsCurrency := TServico(Classe).ValorTotal;
    qryConsulta.ParamByName('ser_id').AsInteger := TServico(Classe).Id;
    qryConsulta.ExecSQL;
  end;

  if TServico(Classe).QtdItens > 0 then
  begin
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('insert into servicos_itens (sit_id, ser_id_fk, tip_id_fk, sit_valor)');
    qryConsulta.SQL.Add('values (:sit_id, :ser_id_fk, :tip_id_fk, :sit_valor)');
    qryConsulta.SQL.Add('on duplicate key update tip_id_fk = values(tip_id_fk), sit_valor = values(sit_valor)');

    for Cont := 0 to TServico(Classe).QtdItens - 1 do
    begin
      if TServico(Classe).RetornaItemPos(Cont).Id = 0 then
      begin
        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add('select max(sit_id) + 1 as novo_id from servicos_itens');
        qryAux.SQL.Add('WHERE ser_id_fk = :ser_id_fk');
        qryAux.ParamByName('ser_id_fk').AsInteger := TServico(Classe).Id;
        qryAux.Open;

        TServico(Classe).RetornaItemPos(Cont).Id := qryAux.FieldByName('novo_id').AsInteger;
      end;

      qryConsulta.ParamByName('sit_id').AsInteger := TServico(Classe).RetornaItemPos(Cont).Id;
      qryConsulta.ParamByName('ser_id_fk').AsInteger := TServico(Classe).Id;
      qryConsulta.ParamByName('tip_id_fk').AsInteger := TServico(Classe).RetornaItemPos(Cont).Tipo.Id;
      qryConsulta.ParamByName('sit_valor').AsCurrency := TServico(Classe).RetornaItemPos(Cont).Valor;
      qryConsulta.ExecSQL;
    end;
  end;

  if (TServico(Classe).ItensExcluidos.Count > 0) then
  begin
    for Cont := TServico(Classe).ItensExcluidos.Count - 1 downto 0 do
    begin
      qryConsulta.Close;
      qryConsulta.SQL.Clear;
      qryConsulta.SQL.Add('delete from servicos_itens where sit_id = :sit_id and ser_id_fk = :ser_id_fk');
      qryConsulta.ParamByName('sit_id').AsInteger := TServico(Classe).RetornaItemPos(Cont).Id;
      qryConsulta.ParamByName('ser_id_fk').AsInteger := TServico(Classe).Id;
      qryConsulta.ExecSQL;
    end;

    TServico(Classe).ItensExcluidos.Clear;
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
