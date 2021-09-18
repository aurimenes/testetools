unit classServicos;

interface

uses classFarmaceutico, classPacientes, System.Classes;

type
  TServicos = class
  private
    FID: Integer;
    FFarmaceutico: TFarmaceutico;
    FPaciente: TPaciente;
    FObservacoes: TStringList;
    FItens: TList;
    FValorTotal: Currency;
    procedure SetObservacoes(const Value: TStringList);
    procedure SetItens(const Value: TList);
  public
    constructor Create;
    destructor Destroy;
    property Id: Integer read FID;
    property Farmaceutico: TFarmaceutico read FFarmaceutico;
    procedure SetFarmaceutico(Id: Integer);
    property Paciente: TPaciente read FPaciente;
    procedure SetPaciente(Id: Integer);
    property Observacoes: TStringList read FObservacoes write SetObservacoes;
    property Itens: TList read FItens write SetItens;
    property ValorTotal: Currency read FValorTotal;
  end;

implementation

{ TServicos }

constructor TServicos.Create;
begin
  FFarmaceutico := TFarmaceutico.Create;
  FPaciente := TPaciente.Create;
  FObservacoes := TStringList.Create;
  FITens := TList.Create;
end;

destructor TServicos.Destroy;
begin
  FObservacoes.Free;
  FFarmaceutico.Free;
  FPaciente.Free;
  FItens.Free;
end;

procedure TServicos.SetFarmaceutico(Id: Integer);
begin

end;

procedure TServicos.SetItens(const Value: TList);
begin
  FItens := Value;
end;

procedure TServicos.SetObservacoes(const Value: TStringList);
begin
  FObservacoes := Value;
end;

procedure TServicos.SetPaciente(Id: Integer);
begin

end;

end.
