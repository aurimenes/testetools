unit classServico;

interface

uses Classe, SysUtils, classFarmaceutico, classPaciente, classServicoItem, System.Classes;

type
  TServico = class(TClasse)
  private
    FFarmaceutico: TFarmaceutico;
    FPaciente: TPaciente;
    FObservacoes: TStringList;
    FItens: TList;
    FValorTotal: Currency;
    procedure SetObservacoes(const Value: TStringList);
    procedure SetFarmaceutico(const Value: TFarmaceutico);
    procedure SetValorTotal(const Value: Currency);
    procedure SetPaciente(const Value: TPaciente);
    function RetornaItem(IdItem: Integer): TServicoItem;
  public
    constructor Create;
    destructor Destroy;

    property Farmaceutico: TFarmaceutico read FFarmaceutico write SetFarmaceutico;
    property Paciente: TPaciente read FPaciente write SetPaciente;
    property Observacoes: TStringList read FObservacoes write SetObservacoes;
    property ValorTotal: Currency read FValorTotal write SetValorTotal;

    procedure AdicionaItem(Item: TServicoItem);
    procedure ExcluiItem(IdItem: Integer);
    function ListaItens: TList;
    function RetornaItemId(IdItem: Integer): TServicoItem;
    function RetornaItemPos(PosItem: Integer): TServicoItem;
    procedure LimpaItens;
    function QtdItens: Integer;
  end;

implementation

{ TServicos }

procedure TServico.AdicionaItem(Item: TServicoItem);
begin
  FItens.Add(Item);

  ValorTotal := ValorTotal + Item.Valor;
end;

constructor TServico.Create;
begin
  FFarmaceutico := TFarmaceutico.Create;
  FPaciente := TPaciente.Create;
  FObservacoes := TStringList.Create;
  FITens := TList.Create;

  ValorTotal := 0;
end;

destructor TServico.Destroy;
begin
  FObservacoes.Free;
  FFarmaceutico.Free;
  FPaciente.Free;
  FItens.Free;
end;

procedure TServico.ExcluiItem(IdItem: Integer);
begin
  { TODO : Diminuir o valor total }
end;

procedure TServico.LimpaItens;
var
  Cont: Integer;
begin
  for Cont := FItens.Count - 1 downto 0 do
  begin
    TServicoItem(FItens[Cont]).Free;
    FItens.Delete(Cont);
  end;
end;

function TServico.ListaItens: TList;
begin

end;

function TServico.QtdItens: Integer;
begin
  Result := FItens.Count;
end;

function TServico.RetornaItem(IdItem: Integer): TServicoItem;
begin

end;

function TServico.RetornaItemId(IdItem: Integer): TServicoItem;
begin

end;

function TServico.RetornaItemPos(PosItem: Integer): TServicoItem;
begin
  Result := TServicoItem(FItens[PosItem]);
end;

procedure TServico.SetFarmaceutico(const Value: TFarmaceutico);
begin
  FFarmaceutico := Value;
end;

procedure TServico.SetObservacoes(const Value: TStringList);
begin
  FObservacoes := Value;
end;

procedure TServico.SetPaciente(const Value: TPaciente);
begin
  FPaciente := Value;
end;

procedure TServico.SetValorTotal(const Value: Currency);
begin
  FValorTotal := Value;
end;

end.
