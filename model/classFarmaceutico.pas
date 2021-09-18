unit classFarmaceutico;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.Client, Data.DB,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TFarmaceutico = class
  private
    FId: Integer;
    FNome: String;
    procedure SetNome(const Value: String);
  public
    property Id: Integer read FId;
    property Nome: String read FNome write SetNome;
    procedure Carregar(Id: Integer);
    procedure Gravar;
  end;

implementation

{ TFarmaceutico }

uses uDM;

procedure TFarmaceutico.Carregar(Id: Integer);
var
  qryConsulta: TFDQuery;
begin
  qryConsulta := TFDQuery.Create(Nil);

  try
    qryConsulta.Connection := DM.DB;
    qryConsulta.SQL.Add('select far_nome from farmaceuticos');
    qryConsulta.SQL.Add('where far_id = :far_id');
    qryConsulta.ParamByName('far_id').AsInteger := Id;
    qryConsulta.Open;

    if qryConsulta.IsEmpty then
    begin
      FId := -1;
      FNome := '';
    end
    else
    begin
      FId := Id;
      FNome := qryConsulta.FieldByName('far_nome').AsString;
    end;
  finally
    qryConsulta.Free
  end;
end;

procedure TFarmaceutico.Gravar;
var
  qryConsulta: TFDQuery;
begin
  if FId = -1 then
    raise Exception.Create('Farmacêutico Inexistente!');

  qryConsulta := TFDQuery.Create(Nil);

  try
    qryConsulta.Connection := DM.DB;

    if Fid = 0 then
    begin
      qryConsulta.SQL.Add('INSERT INTO farmaceuticos (far_nome)');
      qryConsulta.SQL.Add('values (:far_nome');

    end

    qryConsulta.SQL.Add('SELECT FAR_NOME FROM farmaceuticos');
    qryConsulta.SQL.Add('WHERE FAR_ID = :FAR_ID');
    qryConsulta.ParamByName('FAR_ID').AsInteger := Id;
    qryConsulta.Open;
  finally
    qryConsulta.Free;
  end;
end;

procedure TFarmaceutico.SetNome(const Value: String);
begin
  FNome := Value;
end;

end.
